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

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate WobbleBubbleButton into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "quangtqag/WobbleBubbleButton" ~> 0.0.5
```

Run `carthage update` to build the framework and drag the built `WobbleBubbleButton.framework` into your Xcode project.

*There is a bug in Xcode 7.2 when you use WobbleBubbleButton in interface builder at this time. You need to set Custom Class and Module to WobbleBubbleButton manually since Xcode did not automatically complete it for you.*

## Requirements

- iOS 8.0+
- Xcode 7+

## License

WobbleBubbleButton is released under the MIT license. See LICENSE for details.
