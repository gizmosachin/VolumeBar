//
//  SystemVolumeManager.swift
//
//  Copyright (c) 2016-Present Sachin Patel (http://gizmosachin.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import AVFoundation

@objc internal protocol SystemVolumeObserver {
	func volumeChanged(to volume: Float)
}

internal final class SystemVolumeManager: NSObject {
	fileprivate let observers: NSHashTable<SystemVolumeObserver>
	fileprivate var isObservingSystemVolumeChanges: Bool = false
	
	internal override init() {
		observers = NSHashTable<SystemVolumeObserver>.weakObjects()
		
		super.init()
		
		startObservingSystemVolumeChanges()
		startObservingApplicationStateChanges()
	}
	
	deinit {
		observers.removeAllObjects()
		
		stopObservingSystemVolumeChanges()
		stopObservingApplicationStateChanges()
	}

	public func volumeChanged(to volume: Float) {
		for case let observer as SystemVolumeObserver in observers.objectEnumerator() {
			observer.volumeChanged(to: volume)
		}
	}
}

// System Volume Changes
internal extension SystemVolumeManager {
	func startObservingSystemVolumeChanges() {
        	try? AVAudioSession.sharedInstance().setActive(true)
		
		if !isObservingSystemVolumeChanges {
			// Observe system volume changes
			AVAudioSession.sharedInstance().addObserver(self, forKeyPath: #keyPath(AVAudioSession.outputVolume), options: [.old, .new], context: nil)
			
			// We need to manually set this to avoid adding ourselves as an observer twice.
			// This can happen if VolumeBar is started and the app has just launched.
			// Without this, KVO retains us and we crash when system volume changes after stop() is called. :(
			isObservingSystemVolumeChanges = true
		}
	}
	
	func stopObservingSystemVolumeChanges() {
		// Stop observing system volume changes
		if isObservingSystemVolumeChanges {
			AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: #keyPath(AVAudioSession.outputVolume))
			isObservingSystemVolumeChanges = false
		}
	}
	
	/// Observe changes in volume.
	///
	/// This method is called when the user presses either of the volume buttons.
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
		let volume = AVAudioSession.sharedInstance().outputVolume
		volumeChanged(to: volume)
	}
}

// Application State Changes
internal extension SystemVolumeManager {
	func startObservingApplicationStateChanges() {
		// Add application state observers
		NotificationCenter.default.addObserver(self, selector: #selector(SystemVolumeManager.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(SystemVolumeManager.applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
	}
	
	func stopObservingApplicationStateChanges() {
		// Remove application state observers
		NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
	}
	
	/// Observe when the application background state changes.
	@objc func applicationWillResignActive(notification: Notification) {
		// Stop observing volume while in the background
		stopObservingSystemVolumeChanges()
	}
	
	@objc func applicationDidBecomeActive(notification: Notification) {
		// Restart session after becoming active
		startObservingSystemVolumeChanges()
	}
}

// Volume Manager Observers
internal extension SystemVolumeManager {
	func addObserver(_ observer: SystemVolumeObserver) {
		observers.add(observer)
	}
	
	func removeObserver(_ observer: SystemVolumeObserver) {
		observers.remove(observer)
	}
}
