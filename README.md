# YOChartImageKit

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/YOChartImageKit.svg?style=flat)](http://cocoadocs.org/docsets/YOChartImageKit)
[![License](https://img.shields.io/cocoapods/l/YOChartImageKit.svg?style=flat)](http://cocoadocs.org/docsets/YOChartImageKit)
[![Platform](https://img.shields.io/cocoapods/p/YOChartImageKit.svg?style=flat)](http://cocoadocs.org/docsets/YOChartImageKit)


Since watchOS does not have _UIView_ class, YOChartImageKit draws a _UIImage_ of a chart with given values.  
Values and colors can be customized.

![watchos](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/all.png)

![ios](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/ios/all.png)

## Installation

### CocoaPods

```ruby
use_frameworks!

pod 'YOChartImageKit', '~> 1.1'
```

### Carthage

```
github "yasuoza/YOChartImageKit" ~> 1.1
```

### CocoaSeeds

```ruby
# For both iOS and watchOS framework
target 'YOChartImageKit' do
  github 'yasuoza/YOChartImageKit', '1.1.0', files: 'Source/YOChartImageKit/*.{h,m}'
end
```

## Configuration

Following section describes the way to draw charts.  
If you want to try YOChartImageKit, open `YOChartImageKit.xcodeproj`. Example applications are available for iOS and watchOS.

### Line chart

#### solid

![](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/0_solid_line.png)

```swift
let image = YOLineChartImage()
image.strokeWidth = 4.0              // width of line
image.strokeColor = randomColor()    // color of line
image.values = [0.0, 1.0, 2.0]       // chart values
image.smooth = false                 // disable smooth line
image.drawImage(frame, scale: scale) // draw an image
```

#### smooth

![](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/0_smooth_line.png)

```swift
let image = YOLineChartImage()
image.strokeWidth = 4.0              // width of line
image.fillColor = randomColor()      // color of area
image.values = [0.0, 1.0, 2.0]       // chart values
// image.smooth = true               // [default] draws a smooth line
image.drawImage(frame, scale: scale) // draw an image
```

### Bar chart

#### Vertical

![](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/1_bar.png)

```swift
let image = YOBarChartImage()
image.values = [0.0, 1.0, 2.0]       // chart values
image.fillColor = randomColor()      // color of bars
// image.barPadding = 2.0            // [optional] padding of bars
// image.barStyle = .Vertical        // [default] draws a vertical bars
image.drawImage(frame, scale: scale) // draw an image
```

#### Horizontal

![](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/1_horizontal_bar.png)

```swift
let image = YOBarChartImage()
image.values = [0.0, 1.0, 2.0]       // chart values
image.fillColor = randomColor()      // color of bars
// image.barPadding = 2.0            // [optional] padding of bars
image.barStyle = .Horizontal         // draws a horizontal bars
image.drawImage(frame, scale: scale) // draw an image
```

### Donut chart

![](https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/2_donut.png)

```swift
let image = YODonutChartImage()
image.donutWidth = 16.0                           // width of donut
// image.labelText = "LABEL"                      // [optional] center label text
// image.labelColor = UIColor.whiteColor()        // [optional] center label color
image.values = [10.0, 20.0, 70.0]                 // chart values
image.colors = (0..<3).map { _ in randomColor() } // colors of pieces
image.drawImage(frame, scale: scale)              // draw an image
```

## Framework Requirements

- watchOS ~> 2.0

## Build Requirements

- Xcode >= 7.1

## Example Application

Example applications are available for both iOS and watchOS.  

```
pod try YOChartImageKit
```

or open `YOChartImageKit.xcodeproj` with Xcode and build demo app.
