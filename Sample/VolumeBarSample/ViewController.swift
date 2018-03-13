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
	let label: UILabel
	let stackView: UIStackView
	
	let mock: VolumeBarMock
	
	func createLooperButton() -> UIButton {
		return VolumeBarSampleButton("Start Automatic Preview") { (button: UIButton) in
			let started = self.mock.automaticPreviewIsRunning
			if started {
				self.mock.stopAutomaticPreview()
				button.setTitle("Start Automatic Preview", for: .normal)
			} else {
				self.mock.startAutomaticPreview()
				button.setTitle("Stop Automatic Preview", for: .normal)
			}
		}
	}
	
	let likeInstagramButton: UIButton = {
		return VolumeBarSampleButton("Use Instagram Style") { _ in
			VolumeBar.shared.style = .likeInstagram
		}
	}()
	
	let likeSnapchatButton: UIButton = {
		return VolumeBarSampleButton("Use Snapchat Style") { _ in
			VolumeBar.shared.style = .likeSnapchat
		}
	}()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		label = UILabel()
		label.font = .systemFont(ofSize: 36, weight: .medium)
		label.text = "VolumeBar"
		label.textAlignment = .center
		
		stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.spacing = 20
		
		mock = VolumeBarMock()
		
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Add the stack view
		view.addSubview(stackView)
		
		// Add buttons
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(createLooperButton())
		stackView.addArrangedSubview(likeInstagramButton)
		stackView.addArrangedSubview(likeSnapchatButton)
		
		// Extra spacing after header label
		if #available(iOS 11.0, *) {
			stackView.setCustomSpacing(40, after: label)
		}
		
		// Add constraints
		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.widthAnchor.constraint(equalToConstant: 280),
			stackView.heightAnchor.constraint(equalToConstant: 300)
		])
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Don't interrupt user audio
		try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
		
		// Initial style
		VolumeBar.shared.style = .likeInstagram
		VolumeBar.shared.start()
	}
}
