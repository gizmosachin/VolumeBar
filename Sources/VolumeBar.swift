//
//  VolumeBar.swift
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
import AudioToolbox
import MediaPlayer

public final class VolumeBar {
	/// The shared VolumeBar singleton.
	public static let shared = VolumeBar()
	
	/// The stack view that displays the volume bar.
	public var view: UIStackView?

	// MARK: Animation
	
	/// The minimum visible duration that VolumeBar will appear on screen after a volume button is pressed.
	/// If VolumeBar is already showing and a volume button is pressed, VolumeBar will continue to show
	/// and the duration it's displayed on screen will be extended by this number of seconds.
	public var minimumVisibleDuration: TimeInterval = 1.5
	
	/// The animation used to show VolumeBar.
	public var showAnimation: VolumeBarAnimation = .fadeIn
	
	/// The animation used to hide VolumeBar.
	public var hideAnimation: VolumeBarAnimation = .fadeOut
	
	
	// MARK: Style
	
	/// The current style of VolumeBar.
	public var style: VolumeBarStyle = VolumeBarStyle() {
		didSet {
			window?.apply(style: style)
			
			if let stackView = view as? VolumeBarStackView {
				stackView.apply(style: style)
			}
		}
	}
	
	// MARK: Internal
	internal var window: VolumeBarWindow?
	internal var timer: Timer?
	internal var systemVolumeManager: SystemVolumeManager?
}

public extension VolumeBar {
	// MARK: Lifecycle

	/// Start VolumeBar and automatically show when the volume changes.
	func start() {
		// If we have a systemVolumeManager, we're already started.
		guard systemVolumeManager == nil else { return }
		
		let stackView = VolumeBarStackView()
		stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		let viewController = UIViewController()
		viewController.view.addSubview(stackView)
		
		self.view = stackView
		self.window = VolumeBarWindow(viewController: viewController)
		
		// Initial style
		stackView.apply(style: style)
		window?.apply(style: style)
		
		// Start observing changes in system volume
		systemVolumeManager = SystemVolumeManager()
		systemVolumeManager?.addObserver(self)
		systemVolumeManager?.addObserver(stackView)
	}
	
	/// Stop VolumeBar from automatically showing when the volume changes.
	func stop() {
		hide()
		window = nil
		systemVolumeManager = nil
	}
}

public extension VolumeBar {
	// MARK: Presentation

	/// Show VolumeBar immediately using the current `showAnimation`.
	func show() {
		// Invalidate the timer and extend the on-screen duration
		timer?.invalidate()
		timer = Timer.scheduledTimer(timeInterval: minimumVisibleDuration, target: self, selector: #selector(VolumeBar.hide), userInfo: nil, repeats: false)
		
		window?.show(withAnimation: showAnimation)
	}
	
	/// Show VolumeBar immediately using the current `hideAnimation`.
	@objc func hide() {
		window?.hide(withAnimation: hideAnimation)
	}
}

extension VolumeBar: SystemVolumeObserver {
	internal func volumeChanged(to volume: Float) {
		show()
	}
}
