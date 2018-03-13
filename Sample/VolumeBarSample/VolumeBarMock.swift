//
//  VolumeBarSampleLooper.swift
//  VolumeBarSample
//
//  Created by Sachin on 2/22/18.
//  Copyright © 2018 Sachin Patel. All rights reserved.
//

import Foundation

class VolumeBarMock {
	public var automaticPreviewIsRunning: Bool {
		return timer != nil
	}
	
	private var timer: Timer?
	private var lastVolume: Float = 0.5
	private var increasing: Bool = true
	
	func startAutomaticPreview() {
		self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(VolumeBarMock.toggleVolume), userInfo: nil, repeats: true)
	}
	
	func stopAutomaticPreview() {
		self.timer?.invalidate()
		self.timer = nil
	}
	
	@objc func toggleVolume() {
		if lastVolume >= 1 {
			increasing = false
		} else if lastVolume <= 0 {
			increasing = true
		}
		
		let changeAmount: Float = 1.0 / 16.0
		let change: Float = increasing ? changeAmount : -changeAmount
		let newVolume = max(min(lastVolume + change, 1), 0)
		lastVolume = newVolume
		
		// Note: You can't (and shouldn't) access the `systemVolumeManager` in production
		// because it's `internal` to the VolumeBar module. You can, however, use
		// `@testable import VolumeBar` to access and mock it like this in tests.
		VolumeBar.shared.systemVolumeManager?.volumeChanged(to: newVolume)
	}
}
