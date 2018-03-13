//
//  VolumeBarStyle.swift
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

/// A value type wrapping parameters used to customize the appearance of VolumeBar.
public struct VolumeBarStyle {
	// MARK: Layout
	
	/// The height of the bar that will be displayed on screen.
	public var height: CGFloat = 10
	
	/// Insets from the top edge of the device screen.
	///
	/// If `respectsSafeAreaInsets` is `false`, VolumeBar will be inset from screen edges
	/// by exactly these insets.
	///
	/// If `respectsSafeAreaInsets` is `true`, VolumeBar will be
	/// inset by the sum of the safe area insets of the device and `edgeInsets`.
	///
	/// - seealso: `respectsSafeAreaInsets`
	public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
	
	/// Whether or not VolumeBar should respect `safeAreaInsets` when displaying.
	///
	/// - seealso: `edgeInsets`
	public var respectsSafeAreaInsets: Bool = false

	// MARK: Appearance
	
	/// The number of segments that the VolumeBar is made up of.
	/// Use this with `segmentSpacing` to give VolumeBar a segmented appearance.
	///
	/// The default value, 16, is equal to the number of volume steps on iOS devices.
	/// (When the volume is 0%, pressing volume up exactly 16 times will cause the volume to reach 100%)
	///
	/// - seealso: `segmentSpacing`
	public var segmentCount: UInt = 16
	
	/// The number of points between individual segments in the VolumeBar.
	///
	/// - seealso: `segmentCount`
	public var segmentSpacing: CGFloat = 0
	
	/// The corner radius of the VolumeBar.
	public var cornerRadius: CGFloat = 0
	
	// MARK: Colors
	
	/// The color of the progress displayed on the bar.
	public var progressTintColor: UIColor = .black
	
	/// The background color of the track.
	public var trackTintColor: UIColor = UIColor.black.withAlphaComponent(0.5)
	
	/// The background color behind the track view.
	/// This should match the color of the view behind the VolumeBar, which might be the color of your navigation bar.
	public var backgroundColor: UIColor = .white
}
