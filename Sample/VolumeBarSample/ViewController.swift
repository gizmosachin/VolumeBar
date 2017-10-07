//
//  ViewController.swift
//  VolumeBar
//
//  Created by Sachin on 3/5/16.
//  Copyright © 2016 Sachin Patel. All rights reserved.
//

import UIKit
import AudioToolbox
import MediaPlayer

class ViewController: UIViewController, UIScrollViewDelegate {
//	let titleLabel: UILabel
//	let subtitleLabel: UILabel
//
//	let segmentedControl: UISegmentedControl
//	let imageView: UIImageView
//
//	var statusBarHidden: Bool
//
//	struct Style {
//		var name: String
//		var closure: () -> ()
//	}
//	var styles: [Style]
//
//	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//		titleLabel = UILabel()
//		subtitleLabel = UILabel()
//		segmentedControl = UISegmentedControl()
//		imageView = UIImageView(image: UIImage(named: "BackgroundImage"))
//		statusBarHidden = false
//		styles = [Style]()
//
//		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//		commonInit()
//	}
//
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//	func commonInit() {
//		imageView.contentMode = .scaleAspectFill
//		view.addSubview(imageView)
//
//		titleLabel.text = "VolumeBar"
//		titleLabel.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightMedium)
//		titleLabel.textAlignment = .center
//		view.addSubview(titleLabel)
//
//		subtitleLabel.text = "Press either volume button to view."
//		subtitleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
//		subtitleLabel.numberOfLines = 2
//		subtitleLabel.textAlignment = .center
//		view.addSubview(subtitleLabel)
//
//		configureStyles()
//		segmentedControl.addTarget(self, action: #selector(ViewController.update), for: .valueChanged)
//		segmentedControl.selectedSegmentIndex = 0
//		view.addSubview(segmentedControl)
//
//		update()
//	}
//
//	func configureStyles() {
//		// Default style
//		styles.append(Style(name: "Default", closure: {
//			self.titleLabel.textColor = UIColor.black
//			self.subtitleLabel.textColor = UIColor.black
//			self.imageView.alpha = 0
//			self.segmentedControl.tintColor = self.view.tintColor
//
//			self.statusBarHidden = false
//			self.setNeedsStatusBarAppearanceUpdate()
//
//			VolumeBar.sharedInstance.animationStyle = .slide
//			VolumeBar.sharedInstance.barHeight = 2
//			VolumeBar.sharedInstance.segmentCount = 16
//			VolumeBar.sharedInstance.interitemSpacing = 0
//			VolumeBar.sharedInstance.tintColor = UIColor.black
//			VolumeBar.sharedInstance.backgroundColor = UIColor.white
//			VolumeBar.sharedInstance.trackTintColor = UIColor.black.withAlphaComponent(0.1)
//			VolumeBar.sharedInstance.statusBarHidden = false
//		}))
//
//		// Segmented style
//		styles.append(Style(name: "Segmented", closure: {
//			self.titleLabel.textColor = UIColor.white
//			self.subtitleLabel.textColor = UIColor.white
//			self.imageView.alpha = 1
//			self.segmentedControl.tintColor = UIColor.white
//
//			self.statusBarHidden = true
//			self.setNeedsStatusBarAppearanceUpdate()
//
//			VolumeBar.sharedInstance.animationStyle = .fade
//			VolumeBar.sharedInstance.barHeight = 5
//			VolumeBar.sharedInstance.segmentCount = 8
//			VolumeBar.sharedInstance.interitemSpacing = 3
//			VolumeBar.sharedInstance.tintColor = UIColor.white
//			VolumeBar.sharedInstance.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//			VolumeBar.sharedInstance.trackTintColor = UIColor.clear
//			VolumeBar.sharedInstance.statusBarHidden = true
//		}))
//
//		// Add a segment for each style
//		for (index, style) in styles.enumerated() {
//			segmentedControl.insertSegment(withTitle: style.name, at: index, animated: false)
//		}
//	}
//
//	// MARK: -
//	func update() {
//		let selected = segmentedControl.selectedSegmentIndex
//		if selected < 0 || selected >= styles.count { return }
//		styles[segmentedControl.selectedSegmentIndex].closure()
//	}
//
	// MARK: - View lifecycle
	public var timer: Timer?
	
	public var volume: Float = 0.5
	public var increasing: Bool = true
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Don't interrupt user audio
		try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
		
		VolumeBar.shared.apply(style: .likeSnapchat)
		VolumeBar.shared.start()
		
		self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.toggleVolume), userInfo: nil, repeats: true)
    }
	
	@objc func toggleVolume() {
		guard let manager = VolumeBar.shared.systemVolumeManager else { return }

		if volume >= 1 {
			increasing = false
			VolumeBar.shared.apply(style: .likeInstagram)
		} else if volume <= 0 {
			increasing = true
			VolumeBar.shared.apply(style: .likeSnapchat)
		}

		let changeAmount: Float = 0.0625
		let change: Float = increasing ? changeAmount : -changeAmount
		let newVolume = max(min(volume + change, 1), 0)
		volume = newVolume
		manager.volumeChanged(to: newVolume)
	}
	
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//
//		let labelMargin = CGFloat(20)
//		let controlMargin = CGFloat(20)
//
//		let titleHeight = CGFloat(40)
//		let subtitleHeight = CGFloat(30)
//		titleLabel.frame = CGRect(x: labelMargin, y: (view.bounds.height - titleHeight) / 2, width: view.bounds.width - labelMargin * 2, height: titleHeight)
//		subtitleLabel.frame = CGRect(x: labelMargin, y: (view.bounds.height - titleHeight) / 2 + titleHeight + 10, width: view.bounds.width - labelMargin * 2, height: subtitleHeight)
//		segmentedControl.frame = CGRect(x: controlMargin, y: view.bounds.height - controlMargin - 30, width: view.bounds.width - controlMargin * 2, height: 30)
//		imageView.frame = view.bounds
//	}
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//	override var prefersStatusBarHidden: Bool {
//		return statusBarHidden
//	}
}
