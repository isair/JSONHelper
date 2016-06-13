# JSONHelper
[![CocoaPods](https://img.shields.io/cocoapods/l/JSONHelper.svg)](https://github.com/isair/JSONHelper/blob/master/LICENSE)
![CocoaPods](https://img.shields.io/cocoapods/p/JSONHelper.svg)
[![Build Status](https://travis-ci.org/isair/JSONHelper.svg?branch=master)](https://travis-ci.org/isair/JSONHelper)
[![CocoaPods](https://img.shields.io/cocoapods/v/JSONHelper.svg)](https://cocoapods.org/pods/JSONHelper)

[![Gratipay](https://img.shields.io/gratipay/bsencan91.svg)](https://gratipay.com/bsencan91/)
[![Gitter](https://badges.gitter.im/JOIN CHAT.svg)](https://gitter.im/isair/JSONHelper?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Convert anything into anything in one operation; hex strings into UIColor/NSColor, JSON strings into class instances, y/n strings to booleans, arrays and dictionaries of these; anything you can make sense of!

__Latest version requires iOS 8+ and Xcode 7.3+__

## Table of Contents

1. [Installation](#installation)
2. [The <-- Operator](#the----operator)
3. [Convertible Protocol](#convertible-protocol)
4. [Deserializable Protocol](#deserializable-protocol) (with JSON deserialization example)
5. [Serializable Protocol](#serializable-protocol)

## Installation

### [CocoaPods](https://github.com/CocoaPods/CocoaPods)

Add the following line in your `Podfile`.

```
pod "JSONHelper"
```

### [Carthage](https://github.com/Carthage/Carthage#installing-carthage)

Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

```
github "isair/JSONHelper"
```

Then do `carthage update`. After that, add the framework to your project.

## The <-- Operator

The `<--` operator takes the value on its right hand side and tries to convert it into the type of the value on its left hand side. If the conversion fails, an error is logged on debug builds. If it's successful, the value of the left hand side variable is overwritten. It's chainable as well.

If the right hand side value is nil or the conversion fails, and the left hand side variable is an optional, then nil is assigned to it. When the left hand side is non-optional, the current value of the left hand side variable is left untouched.

Using this specification let's assume you have a dictionary response that you retrieved from some API with hex color strings in it, under the key `colors`, that you want to convert into an array of UIColor instances. Also, to fully use everything we know, let's also assume that we want to have a default value for our color array in case the value for the key we're looking for does not exist (is nil).

```swift
var colors = [UIColor.blackColor(), UIColor.whiteColor()]
// Assume we have response { "colors": ["#aaa", "#b06200aa"] }
colors <-- response[colorsKey]
```

### Convertible Protocol

If your type is a simple value-like type, adopting the Convertible protocol is the way to make your type work with the `<--` operator.

Example:
```swift
struct Vector2D: Convertible {
  var x: Double = 0
  var y: Double = 0

  init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }

  static func convertFromValue<T>(value: T?) throws -> Self? {
    guard let value = value else { return nil }

    if let doubleTupleValue = value as? (Double, Double) {
      return self.init(x: doubleTupleValue.0, y: doubleTupleValue.1)
    }

    throw ConversionError.UnsupportedType
  }
}
```

```swift
var myVector: Vector2D?
myVector <-- (1.0, 2.7)
```

### Deserializable Protocol

While you can basically adopt the `Convertible` protocol for any type, if your type is always converted from a dictionary or a JSON string then things can get a lot easier with the `Deserializable` protocol.

Example:
```swift
class User: Deserializable {
  static let idKey = "id"
  static let emailKey = "email"
  static let nameKey = "name"
  static let avatarURLKey = "avatar_url"

  private(set) var id: String?
  private(set) var email: String?
  private(set) var name = "Guest"
  private(set) var avatarURL = NSURL(string: "https://mysite.com/assets/default-avatar.png")

  required init(dictionary: [String : AnyObject]) {
    id <-- dictionary[User.idKey]
    email <-- dictionary[User.emailKey]
    name <-- dictionary[User.nameKey]
    avatarURL <-- dictionary[User.avatarURLKey]
  }
}
```

```swift
var myUser: User?
user <-- apiResponse["user"]
```

### Serializable Protocol

// Serialization is coming soon. I'll probably not add a new protocol and just rename and update the Deserializable protocol and turn it into a mixin.
