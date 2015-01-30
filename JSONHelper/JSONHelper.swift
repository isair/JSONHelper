//
//  JSONHelper.swift
//
//  Created by Baris Sencan on 28/08/2014.
//  Copyright 2014 Baris Sencan
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://github.com/isair/JSONHelper
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import Foundation

// Internally used functions, but defined as public as they might serve some
// purpose outside this library.
public func JSONString(object: AnyObject?) -> String? {
  return object as? String
}

public func JSONStrings(object: AnyObject?) -> [String]? {
  return object as? [String]
}

public func JSONInt(object: AnyObject?) -> Int? {
  return object as? Int
}

public func JSONInts(object: AnyObject?) -> [Int]? {
  return object as? [Int]
}

public func JSONBool(object: AnyObject?) -> Bool? {
  return object as? Bool
}

public func JSONBools(object: AnyObject?) -> [Bool]? {
  return object as? [Bool]
}

public func JSONArray(object: AnyObject?) -> [AnyObject]? {
  return object as? [AnyObject]
}

public func JSONObject(object: AnyObject?) -> [String: AnyObject]? {
  return object as? [String: AnyObject]
}

public func JSONObjects(object: AnyObject?) -> [[String: AnyObject]]? {
  return object as? [[String: AnyObject]]
}

// Operator for use in "if let" conversions.
infix operator >>> { associativity left precedence 150 }

public func >>> <A, B>(a: A?, f: A -> B?) -> B? {

  if let x = a {
    return f(x)
  } else {
    return nil
  }
}

// MARK: - Operator for quick primitive type deserialization.

infix operator <<< { associativity right precedence 150 }

// For optionals.
public func <<< <T>(inout property: T?, value: AnyObject?) -> T? {
  var newValue: T?

  if let unwrappedValue: AnyObject = value {

    if let convertedValue = unwrappedValue as? T { // Direct conversion.
      newValue = convertedValue
    } else if property is Int? && unwrappedValue is String { // String -> Int

      if let intValue = "\(unwrappedValue)".toInt() {
        newValue = intValue as T
      }
    } else if property is NSURL? { // String -> NSURL

      if let stringValue = unwrappedValue as? String {
        newValue = NSURL(string: stringValue) as T?
      }
    } else if property is NSDate? { // Int || Double || NSNumber -> NSDate

      if let timestamp = value as? Int {
        newValue = NSDate(timeIntervalSince1970: Double(timestamp)) as T
      } else if let timestamp = value as? Double {
        newValue = NSDate(timeIntervalSince1970: timestamp) as T
      } else if let timestamp = value as? NSNumber {
        newValue = NSDate(timeIntervalSince1970: timestamp.doubleValue) as T
      }
    }
  }
  property = newValue
  return property
}

// For non-optionals.
public func <<< <T>(inout property: T, value: AnyObject?) -> T {
  var newValue: T?
  newValue <<< value
  if let newValue = newValue { property = newValue }
  return property
}

// Special handling for value and format pair to NSDate conversion.
public func <<< (inout property: NSDate?, valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> NSDate? {
  var newValue: NSDate?

  if let dateString = valueAndFormat.value >>> JSONString {

    if let formatString = valueAndFormat.format >>> JSONString {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = formatString

      if let newDate = dateFormatter.dateFromString(dateString) {
        newValue = newDate
      }
    }
  }
  property = newValue
  return property
}

public func <<< (inout property: NSDate, valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> NSDate {
  var date: NSDate?
  date <<< valueAndFormat
  if let date = date { property = date }
  return property
}

// MARK: - Operator for quick primitive array deserialization.

infix operator <<<* { associativity right precedence 150 }

public func <<<* (inout array: [String]?, value: AnyObject?) -> [String]? {

  if let stringArray = value >>> JSONStrings {
    array = stringArray
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [String], value: AnyObject?) -> [String] {
  var newValue: [String]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [Int]?, value: AnyObject?) -> [Int]? {

  if let intArray = value >>> JSONInts {
    array = intArray
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [Int], value: AnyObject?) -> [Int] {
  var newValue: [Int]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [Float]?, value: AnyObject?) -> [Float]? {

  if let floatArray = value as? [Float] {
    array = floatArray
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [Float], value: AnyObject?) -> [Float] {
  var newValue: [Float]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [Double]?, value: AnyObject?) -> [Double]? {

  if let doubleArrayDoubleExcitement = value as? [Double] {
    array = doubleArrayDoubleExcitement
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [Double], value: AnyObject?) -> [Double] {
  var newValue: [Double]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [Bool]?, value: AnyObject?) -> [Bool]? {

  if let boolArray = value >>> JSONBools {
    array = boolArray
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [Bool], value: AnyObject?) -> [Bool] {
  var newValue: [Bool]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [NSURL]?, value: AnyObject?) -> [NSURL]? {

  if let stringURLArray = value >>> JSONStrings {
    array = [NSURL]()

    for stringURL in stringURLArray {

      if let url = NSURL(string: stringURL) {
        array!.append(url)
      }
    }
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [NSURL], value: AnyObject?) -> [NSURL] {
  var newValue: [NSURL]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [NSDate]?, valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> [NSDate]? {
  var newValue: [NSDate]?

  if let dateStringArray = valueAndFormat.value >>> JSONStrings {

    if let formatString = valueAndFormat.format >>> JSONString {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = formatString
      newValue = [NSDate]()

      for dateString in dateStringArray {

        if let date = dateFormatter.dateFromString(dateString) {
          newValue!.append(date)
        }
      }
    }
  }
  array = newValue
  return array
}

public func <<<* (inout array: [NSDate], valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> [NSDate] {
  var newValue: [NSDate]?
  newValue <<<* valueAndFormat
  if let newValue = newValue { array = newValue }
  return array
}

public func <<<* (inout array: [NSDate]?, value: AnyObject?) -> [NSDate]? {

  if let timestamps = value as? [AnyObject] {
    array = [NSDate]()

    for timestamp in timestamps {
      var date: NSDate?
      date <<< timestamp
      if date != nil { array!.append(date!) }
    }
  } else {
    array = nil
  }
  return array
}

public func <<<* (inout array: [NSDate], value: AnyObject?) -> [NSDate] {
  var newValue: [NSDate]?
  newValue <<<* value
  if let newValue = newValue { array = newValue }
  return array
}

// MARK: - Operator for quick class deserialization.

infix operator <<<< { associativity right precedence 150 }

public protocol Deserializable {
  init(data: [String: AnyObject])
}

public func <<<< <T: Deserializable>(inout instance: T?, dataObject: AnyObject?) -> T? {

  if let data = dataObject >>> JSONObject {
    instance = T(data: data)
  } else {
    instance = nil
  }
  return instance
}

public func <<<< <T: Deserializable>(inout instance: T, dataObject: AnyObject?) -> T {
  var newInstance: T?
  newInstance <<<< dataObject
  if let newInstance = newInstance { instance = newInstance }
  return instance
}

// MARK: - Operator for quick deserialization into an array of instances of a deserializable class.

infix operator <<<<* { associativity right precedence 150 }

public func <<<<* <T: Deserializable>(inout array: [T]?, dataObject: AnyObject?) -> [T]? {

  if let dataArray = dataObject >>> JSONObjects {
    array = [T]()

    for data in dataArray {
      array!.append(T(data: data))
    }
  } else {
    array = nil
  }
  return array
}

public func <<<<* <T: Deserializable>(inout array: [T], dataObject: AnyObject?) -> [T] {
  var newArray: [T]?
  newArray <<<<* dataObject
  if let newArray = newArray { array = newArray }
  return array
}

// MARK: - Overloading of own operators for deserialization of JSON strings.

private func dataStringToObject(dataString: String) -> AnyObject? {
  var data: NSData = dataString.dataUsingEncoding(NSUTF8StringEncoding)!
  var error: NSError?
  return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
}

public func <<<< <T: Deserializable>(inout instance: T?, dataString: String) -> T? {
  return instance <<<< dataStringToObject(dataString)
}

public func <<<< <T: Deserializable>(inout instance: T, dataString: String) -> T {
  return instance <<<< dataStringToObject(dataString)
}

public func <<<<* <T: Deserializable>(inout array: [T]?, dataString: String) -> [T]? {
  return array <<<<* dataStringToObject(dataString)
}

public func <<<<* <T: Deserializable>(inout array: [T], dataString: String) -> [T] {
  return array <<<<* dataStringToObject(dataString)
}
