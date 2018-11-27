![VolumeBar](https://github.com/gizmosachin/VolumeBar/raw/master/VolumeBar.gif)

## VolumeBar

VolumeBar is a [Swift](https://developer.apple.com/swift/) volume indicator that doesn't obstruct content on screen.

[![Build Status](https://travis-ci.org/gizmosachin/VolumeBar.svg?branch=master)](https://travis-ci.org/gizmosachin/VolumeBar) ![Pod Version](https://img.shields.io/cocoapods/v/VolumeBar.svg) [![Swift Version](https://img.shields.io/badge/language-swift%204.0-brightgreen.svg)](https://developer.apple.com/swift) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)

|              | Features                                 |
| :----------: | :--------------------------------------- |
|  :no_good:   | Hides system volume HUD automatically    |
|    :art:     | Customizable appearance with presets     |
|    :boom:    | Support for custom animations            |
|   :iphone:   | Works with iPhone X                      |
|   :books:    | Fully [documented](http://gizmosachin.github.io/VolumeBar) |
| :baby_chick: | [Swift 4](https://developer.apple.com/swift/) |


## Usage

It's super easy to add VolumeBar to your app:

```swift
let volumeBar = VolumeBar.shared
volumeBar.style = .likeInstagram
volumeBar.start()
```

Customize appearance attributes (see [`VolumeBarStyle`](http://gizmosachin.github.io/VolumeBar/Structs/VolumeBarStyle.html)):
```swift
let volumeBar = VolumeBar.shared
var customStyle = VolumeBarStyle.likeInstagram
customStyle.trackTintColor = .white
customStyle.trackTintColor = .darkGray
customStyle.backgroundColor = .black
volumeBar.style = customStyle
```

Or even use custom animations (see [`VolumeBarAnimation`](http://gizmosachin.github.io/VolumeBar/Structs/VolumeBarAnimation.html)):
```swift
let volumeBar = VolumeBar.shared
let fadeInAnimation = VolumeBarAnimation({ (view, completion) in
	view.alpha = 0
	UIView.animate(withDuration: 0.2, animations: {
		view.alpha = 1
	}, completion: completion)
})
volumeBar.showAnimation = fadeInAnimation
```

### Background Audio
If your app doesn't do custom audio handling, adding VolumeBar will make background music (like Spotify) pause when your app is opened.

Prevent this by adding the following wherever you call `VolumeBar.shared.start()`:

```swift
try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
```

### VolumeBar

VolumeBar is fully documented [here](http://gizmosachin.github.io/VolumeBar/).

## Installation

### [CocoaPods](http://cocoapods.org/)

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'VolumeBar', '~> 3.0.4'
```

### [Carthage](https://github.com/Carthage/Carthage)

```ogdl
github "gizmosachin/VolumeBar" "master"
```

## Sample
Please see the `Sample` directory for a basic iOS project that uses `VolumeBar`.

## Contributing
VolumeBar is a community - contributions and discussions are welcome!

Please read the [contributing guidelines](CONTRIBUTING.md) prior to submitting a Pull Request.

## License

VolumeBar is available under the MIT license, see the [LICENSE](https://github.com/gizmosachin/VolumeBar/blob/master/LICENSE) file for more information.
