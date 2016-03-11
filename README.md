# WobbleBubbleButton
Create wobble bubble buttons that same as in Game Center, although it does not look like much. Written by Swift.
The buttons with animations is fun and attracting users. Especially, natural effects is more attractive.

![](https://github.com/quangtqag/WobbleBubbleButton/blob/master/Screenshots/preview.gif)

## Features
* WobbleBubbleButton was inherited from UIButton, so you can set its properties as normal buttons.
* Support @IBDesignable, so you can see it directly in interface builder.

## Usage

You need to import WobbleBubbleButton into place that you want to use

```swift
import WobbleBubbleButton
```

And set properties for it

```swift
button.backgroundColor = UIColor.purpleColor()
button.setTitle("Awesome", forState: .Normal)
```

## Installation
### CocoaPods

You can install the latest release version of CocoaPods with the following command:

```bash
$ gem install cocoapods
```

*CocoaPods v0.36 or later required*

Simply add the following line to your Podfile:

```ruby
platform :ios, '8.0' 
use_frameworks!

pod 'WobbleBubbleButton', '~> 0.0.3' 
```

Then, run the following command:

```bash
$ pod install
```

## Requirements

- iOS 8.0+
- Xcode 7+

## License

WobbleBubbleButton is released under the MIT license. See LICENSE for details.
