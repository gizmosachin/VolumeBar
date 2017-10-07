//
//  VolumeBarStyle+Presets.swift
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

public extension VolumeBarStyle {

	// MARK: Presets

	/// A volume bar style like Instagram, where the bar is a continuous progress view
	/// that displays to the left of the notch on iPhone X and covers the full width
	/// of the iOS status bar on all other iOS devices.
	public static let likeInstagram: VolumeBarStyle = UIDevice.current.volumeBar_isiPhoneX ? .leftOfNotch : .fullWidthContinuous
	
	/// A volume bar style like Snapchat, where the bar is a segmented progress view
	/// that displays under the notch and status bar on iPhone X (respecting the device's
	/// safe area insets) and covers the iOS status bar on all other iOS devices.
	public static let likeSnapchat: VolumeBarStyle = {
		var style = VolumeBarStyle()
		style.height = 5
		style.respectsSafeAreaInsets = UIDevice.current.volumeBar_isiPhoneX
		style.edgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
		style.segmentSpacing = 2
		style.segmentCount = 8
		
		style.progressTintColor = #colorLiteral(red: 0.2558486164, green: 0.2558816075, blue: 0.2558295727, alpha: 1)
		style.trackTintColor = .white
		style.backgroundColor = .white
		return style
	}()
	
	/// A volume bar style that displays a continuous progress view and has minimal insets.
	public static let fullWidthContinuous: VolumeBarStyle = {
		var style = VolumeBarStyle()
		style.height = 5
		style.cornerRadius = 3
		style.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
		
		style.progressTintColor = #colorLiteral(red: 0.2558486164, green: 0.2558816075, blue: 0.2558295727, alpha: 1)
		style.trackTintColor = #colorLiteral(red: 0.8537222743, green: 0.8538187146, blue: 0.8536666036, alpha: 1)
		style.backgroundColor = .white
		return style
	}()
	
	/// A volume bar style that displays to the left of the notch on iPhone X.
	public static let leftOfNotch: VolumeBarStyle = {
		var style = VolumeBarStyle()
		style.height = 5
		style.cornerRadius = 3
		style.edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 5, right: 300)
		
		style.progressTintColor = #colorLiteral(red: 0.2558486164, green: 0.2558816075, blue: 0.2558295727, alpha: 1)
		style.trackTintColor = #colorLiteral(red: 0.8537222743, green: 0.8538187146, blue: 0.8536666036, alpha: 1)
		style.backgroundColor = .white
		return style
	}()
	
	/// A volume bar style that displays to the right of the notch on iPhone X.
	public static let rightOfNotch: VolumeBarStyle = {
		var style = VolumeBarStyle()
		style.height = 5
		style.cornerRadius = 3
		style.edgeInsets = UIEdgeInsets(top: 20, left: 300, bottom: 5, right: 20)
		
		style.progressTintColor = #colorLiteral(red: 0.2558486164, green: 0.2558816075, blue: 0.2558295727, alpha: 1)
		style.trackTintColor = #colorLiteral(red: 0.8537222743, green: 0.8538187146, blue: 0.8536666036, alpha: 1)
		style.backgroundColor = .white
		return style
	}()
}

/// :nodoc:
public extension UIDevice {
	public var volumeBar_isiPhoneX: Bool {
		#if arch(i386) || arch(x86_64)
			// We're running on the simulator, so use that to get the simulated model identifier.
			let identifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]
		#else
			// From https://github.com/dennisweissmann/DeviceKit/blob/master/Source/Device.generated.swift
			var systemInfo = utsname()
			uname(&systemInfo)
			let mirror = Mirror(reflecting: systemInfo.machine)
			let identifier = mirror.children.reduce("") { identifier, element in
				guard let value = element.value as? Int8, value != 0 else { return identifier }
				return identifier + String(UnicodeScalar(UInt8(value)))
			}
		#endif
		
		return identifier == "iPhone10,3" || identifier == "iPhone10,6"
	}
}
