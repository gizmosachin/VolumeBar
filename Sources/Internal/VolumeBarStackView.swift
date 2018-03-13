//
//  VolumeBarStackView.swift
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

/// The internal view used by `VolumeBar`.
internal final class VolumeBarStackView: UIStackView {
	internal let trackView: UIView
	
	// MARK: - Init
	public required init() {
		trackView = UIView()
		
		super.init(frame: .zero)
		
		// Layout properties
		axis = .horizontal
		distribution = .fillEqually
		
		// Add track view
		trackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		insertSubview(trackView, at: 0)
	}
	
	public required init(coder aDecoder: NSCoder) {
		fatalError("Please use VolumeBar.shared instead of instantiating VolumeBarStackView directly.")
	}

	internal func apply(style: VolumeBarStyle) {
		// Layout
		self.spacing = style.segmentSpacing
		
		// Remove existing segment views
		arrangedSubviews.forEach(removeArrangedSubview)
		
		// Add segment views
		(0..<style.segmentCount).map { _ in UIView() }.forEach(self.addArrangedSubview)
		
		// Colors
		trackView.backgroundColor = style.trackTintColor
		arrangedSubviews.forEach { (subview) in
			subview.backgroundColor = style.progressTintColor
		}
	}
}

extension VolumeBarStackView: SystemVolumeObserver {
	internal func volumeChanged(to volume: Float) {
		// iOS has 16 volume steps (when the volume is 0%, pressing volume up
		// exactly 16 times will cause the volume to reach 100%). This value
		// was experimentally determined and could change in the future.
		let systemVolumeStepsCount = Float(16)
		
		let segments = Float(arrangedSubviews.count)
		let depthPerSegment = ceil(systemVolumeStepsCount / segments)
		let steps = segments * depthPerSegment
		
		var remaining = round(volume * steps) / Float(depthPerSegment)
		arrangedSubviews.forEach { (segment) in
			let currentSegmentAlpha = max(0, min(1, remaining))
			segment.alpha = CGFloat(currentSegmentAlpha)
			remaining = max(remaining - currentSegmentAlpha, 0)
		}
	}
}

