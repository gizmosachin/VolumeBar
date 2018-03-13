//
//  VolumeBarAnimation.swift
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

/// A value type wrapping a VolumeBarAnimationBlock.
public struct VolumeBarAnimation {
	/// A block used to animate VolumeBar.
	///
	/// VolumeBar does not perform any state changes before animations.
	/// Your block is responsible for the full lifecycle of your animation.
	/// See `VolumeBarAnimation+Presets.swift` for examples of how to do this.
	///
	/// Parameters:
	///   - `view`: The internal view to operate on as part of this animation.
	///   - `completionHandler`: The completion handler that you must call when your animation completes.
	public typealias Block = ((UIView, VolumeBarAnimation.CompletionHandler?) -> Void)
	
	public typealias CompletionHandler = ((Bool) -> Void)
	
	public var animationBlock: VolumeBarAnimation.Block
	
	public init(_ animationBlock: @escaping VolumeBarAnimation.Block) {
		self.animationBlock = animationBlock
	}
}
