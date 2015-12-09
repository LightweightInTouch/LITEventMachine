# LITEventMachine

[![CI Status](http://img.shields.io/travis/Lobanov Dmitry/LITEventMachine.svg?style=flat)](https://travis-ci.org/Lobanov Dmitry/LITEventMachine)
[![Version](https://img.shields.io/cocoapods/v/LITEventMachine.svg?style=flat)](http://cocoapods.org/pods/LITEventMachine)
[![License](https://img.shields.io/cocoapods/l/LITEventMachine.svg?style=flat)](http://cocoapods.org/pods/LITEventMachine)
[![Platform](https://img.shields.io/cocoapods/p/LITEventMachine.svg?style=flat)](http://cocoapods.org/pods/LITEventMachine)

## About

It is a safe wrapper for Notification Center.  
You can forget to unsubscribe from event in correct moment.  

For example, you need receive a special event for making some stuff.  
You can make protocols and delegates, but it is boring.  
You can make subcription for event for Notification Center, but it is to dangerous. You should subscribe your stuff in proper order.  
You can use Swift (hah) or Objective-C (ah) with numerous libraries for event handling, that are too heavy for you.  
Or you can use lightweight safe wrapper for notification center and be ready for easy life.  

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 7.0 or later

## Installation

LITEventMachine is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LITEventMachine"
```

## Author

Lobanov Dmitry, gaussblurinc@gmail.com

## License

LITEventMachine is available under the MIT license. See the LICENSE file for more info.
