//
//  VolumeBarSampleButton.swift
//  VolumeBarSample
//
//  Created by Sachin on 2/22/18.
//  Copyright © 2018 Sachin Patel. All rights reserved.
//

import UIKit

typealias VolumeBarSampleButtonHandler = ((UIButton) -> Void)

class VolumeBarSampleButton: UIButton {
	private var handler: VolumeBarSampleButtonHandler?
	
	convenience init(_ title: String, _ handler: @escaping VolumeBarSampleButtonHandler) {
		self.init(frame: .zero)
		
		self.handler = handler
		
		layer.masksToBounds = true
		layer.cornerRadius = 20
		
		let blue = #colorLiteral(red: 0.008045921102, green: 0.4740749598, blue: 0.9883448482, alpha: 1)
		layer.borderColor = blue.cgColor
		layer.borderWidth = 1
		
		setTitle(title, for: .normal)
		setTitleColor(blue, for: .normal)
		titleLabel?.textAlignment = .center
		
		setBackgroundImage(blue.withAlphaComponent(0.1).tileableImage, for: .highlighted)
		
		addTarget(self, action: #selector(VolumeBarSampleButton.performHandler), for: .touchUpInside)
	}
	
	@objc func performHandler() {
		handler?(self)
	}
}

private extension UIColor {
	var tileableImage: UIImage {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		let context = UIGraphicsGetCurrentContext()!
		context.setFillColor(cgColor)
		context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
}
