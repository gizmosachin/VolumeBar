//
//  VolumeBarAnimation+Presets.swift
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

internal let VolumeBarPresetAnimationDuration = 0.2

extension VolumeBarAnimation {
	// MARK: Presets

	/// A simple fade in animation.
	public static let fadeIn = VolumeBarAnimation({ (view, completion) in
		view.alpha = 0
		UIView.animate(withDuration: VolumeBarPresetAnimationDuration, delay: 0, options: [.beginFromCurrentState], animations: {
			view.alpha = 1
		}, completion: completion)
	})
	
	/// A simple fade out animation.
	public static let fadeOut = VolumeBarAnimation({ (view, completion) in
		view.alpha = 1
		UIView.animate(withDuration: VolumeBarPresetAnimationDuration, delay: 0, options: [.beginFromCurrentState], animations: {
			view.alpha = 0
		}, completion: completion)
	})
	
	/// Fade in and slide down from above the status bar.
	public static let slideAndFadeIn = VolumeBarAnimation({ (view, completion) in
		view.alpha = 0
		view.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
		UIView.animate(withDuration: VolumeBarPresetAnimationDuration, delay: 0, options: [.beginFromCurrentState], animations: {
			view.alpha = 1
			view.transform = .identity
		}, completion: completion)
	})
	
	/// Fade out and slide up to above the status bar.
	public static let slideAndFadeOut = VolumeBarAnimation({ (view, completion) in
		view.alpha = 1
		UIView.animate(withDuration: VolumeBarPresetAnimationDuration, delay: 0, options: [.beginFromCurrentState], animations: {
			view.alpha = 0
			view.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
		}, completion: completion)
	})
}
