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

/// A type of dictionary that only uses strings for keys and can contain any
/// type of object as a value.
public typealias JSONDictionary = [String: AnyObject]

/// Operator for use in deserialization operations.
infix operator <-- { associativity right precedence 150 }

/// Returns nil if given object is of type NSNull.
///
/// :param: object Object to convert.
///
/// :returns: nil if object is of type NSNull, else returns the object itself.
private func convertToNilIfNull(object: AnyObject?) -> AnyObject? {
  if object is NSNull {
    return nil
  }
  return object
}

// MARK: Primitive Type Deserialization

// For optionals.
public func <-- <T>(inout property: T?, value: AnyObject?) -> T? {
  var newValue: T?
  ""
  if let unwrappedValue: AnyObject = convertToNilIfNull(value) {
    // We unwrapped the given value successfully, try to convert.
    if let convertedValue = unwrappedValue as? T {
      // Convert by just type-casting.
      newValue = convertedValue
    } else {
      // Convert by processing the value first.
      switch property {
      case is Int?:
        if unwrappedValue is String {
          if let intValue = Int("\(unwrappedValue)") {
            newValue = intValue as? T
          }
        }
      case is NSURL?:
        newValue = NSURL(string: "\(unwrappedValue)") as? T
      case is NSDate?:
        if let timestamp = unwrappedValue as? Int {
          newValue = NSDate(timeIntervalSince1970: Double(timestamp)) as? T
        } else if let timestamp = unwrappedValue as? Double {
          newValue = NSDate(timeIntervalSince1970: timestamp) as? T
        } else if let timestamp = unwrappedValue as? NSNumber {
          newValue = NSDate(timeIntervalSince1970: timestamp.doubleValue) as? T
        }
      default:
        break
      }
    }
  }
  property = newValue
  return property
}

// For non-optionals.
public func <-- <T>(inout property: T, value: AnyObject?) -> T {
  var newValue: T?
  newValue <-- value
  if let newValue = newValue { property = newValue }
  return property
}

// Special handling for value and format pair to NSDate conversion.
public func <-- (inout property: NSDate?, valueAndFormat: (AnyObject?, AnyObject?)) -> NSDate? {
  var newValue: NSDate?
  if let dateString = convertToNilIfNull(valueAndFormat.0) as? String {
    if let formatString = convertToNilIfNull(valueAndFormat.1) as? String {
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

public func <-- (inout property: NSDate, valueAndFormat: (AnyObject?, AnyObject?)) -> NSDate {
  var date: NSDate?
  date <-- valueAndFormat
  if let date = date { property = date }
  return property
}

// MARK: Primitive Array Deserialization

public func <-- (inout array: [String]?, value: AnyObject?) -> [String]? {
  if let stringArray = convertToNilIfNull(value) as? [String] {
    array = stringArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [String], value: AnyObject?) -> [String] {
  var newValue: [String]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Int]?, value: AnyObject?) -> [Int]? {
  if let intArray = convertToNilIfNull(value) as? [Int] {
    array = intArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Int], value: AnyObject?) -> [Int] {
  var newValue: [Int]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Float]?, value: AnyObject?) -> [Float]? {
  if let floatArray = convertToNilIfNull(value) as? [Float] {
    array = floatArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Float], value: AnyObject?) -> [Float] {
  var newValue: [Float]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Double]?, value: AnyObject?) -> [Double]? {
  if let doubleArrayDoubleExcitement = convertToNilIfNull(value) as? [Double] {
    array = doubleArrayDoubleExcitement
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Double], value: AnyObject?) -> [Double] {
  var newValue: [Double]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Bool]?, value: AnyObject?) -> [Bool]? {
  if let boolArray = convertToNilIfNull(value) as? [Bool] {
    array = boolArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Bool], value: AnyObject?) -> [Bool] {
  var newValue: [Bool]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [NSURL]?, value: AnyObject?) -> [NSURL]? {
  if let stringURLArray = convertToNilIfNull(value) as? [String] {
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

public func <-- (inout array: [NSURL], value: AnyObject?) -> [NSURL] {
  var newValue: [NSURL]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [NSDate]?, valueAndFormat: (AnyObject?, AnyObject?)) -> [NSDate]? {
  var newValue: [NSDate]?
  if let dateStringArray = convertToNilIfNull(valueAndFormat.0) as? [String] {
    if let formatString = convertToNilIfNull(valueAndFormat.1) as? String {
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

public func <-- (inout array: [NSDate], valueAndFormat: (AnyObject?, AnyObject?)) -> [NSDate] {
  var newValue: [NSDate]?
  newValue <-- valueAndFormat
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [NSDate]?, value: AnyObject?) -> [NSDate]? {
  if let timestamps = convertToNilIfNull(value) as? [AnyObject] {
    array = [NSDate]()
    for timestamp in timestamps {
      var date: NSDate?
      date <-- timestamp
      if date != nil { array!.append(date!) }
    }
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [NSDate], value: AnyObject?) -> [NSDate] {
  var newValue: [NSDate]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}


// MARK: Primitive Map Deserialization

public func <-- (inout map: [String: String]?, value: AnyObject?) -> [String: String]? {
  if let stringMap = convertToNilIfNull(value) as? [String: String] {
    map = stringMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: String], value: AnyObject?) -> [String: String] {
  var newValue: [String: String]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Int]?, value: AnyObject?) -> [String: Int]? {
  if let intMap = convertToNilIfNull(value) as? [String: Int] {
    map = intMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Int], value: AnyObject?) -> [String: Int] {
  var newValue: [String: Int]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Float]?, value: AnyObject?) -> [String: Float]? {
  if let floatMap = convertToNilIfNull(value) as? [String: Float] {
    map = floatMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Float], value: AnyObject?) -> [String: Float] {
  var newValue: [String: Float]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Double]?, value: AnyObject?) -> [String: Double]? {
  if let doubleMapDoubleExcitement = convertToNilIfNull(value) as? [String: Double] {
    map = doubleMapDoubleExcitement
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Double], value: AnyObject?) -> [String: Double] {
  var newValue: [String: Double]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Bool]?, value: AnyObject?) -> [String: Bool]? {
  if let boolMap = convertToNilIfNull(value) as? [String: Bool] {
    map = boolMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Bool], value: AnyObject?) -> [String: Bool] {
  var newValue: [String: Bool]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: NSURL]?, value: AnyObject?) -> [String: NSURL]? {
  if let stringURLMap = convertToNilIfNull(value) as? [String: String] {
    map = [String: NSURL]()
    for (key, stringURL) in stringURLMap {
      if let url = NSURL(string: stringURL) {
        map![key] = url
      }
    }
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: NSURL], value: AnyObject?) -> [String: NSURL] {
  var newValue: [String: NSURL]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: NSDate]?, valueAndFormat: (AnyObject?, AnyObject?)) -> [String: NSDate]? {
  var newValue: [String: NSDate]?
  if let dateStringMap = convertToNilIfNull(valueAndFormat.0) as? [String: String] {
    if let formatString = convertToNilIfNull(valueAndFormat.1) as? String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = formatString
      newValue = [String: NSDate]()
      for (key, dateString) in dateStringMap {
        if let date = dateFormatter.dateFromString(dateString) {
          newValue![key] = date
        }
      }
    }
  }
  map = newValue
  return map
}

public func <-- (inout map: [String: NSDate], valueAndFormat: (AnyObject?, AnyObject?)) -> [String: NSDate] {
  var newValue: [String: NSDate]?
  newValue <-- valueAndFormat
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: NSDate]?, value: AnyObject?) -> [String: NSDate]? {
  if let timestamps = convertToNilIfNull(value) as? [String: AnyObject] {
    map = [String: NSDate]()
    for (key, timestamp) in timestamps {
      var date: NSDate?
      date <-- timestamp
      if date != nil { map![key] = date! }
    }
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: NSDate], value: AnyObject?) -> [String: NSDate] {
  var newValue: [String: NSDate]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}


// MARK: Custom Object Deserialization

public protocol Deserializable {
  init(data: JSONDictionary)
}

public func <-- <T: Deserializable>(inout instance: T?, dataObject: AnyObject?) -> T? {
  if let data = convertToNilIfNull(dataObject) as? JSONDictionary {
    instance = T(data: data)
  } else {
    instance = nil
  }
  return instance
}

public func <-- <T: Deserializable>(inout instance: T, dataObject: AnyObject?) -> T {
  var newInstance: T?
  newInstance <-- dataObject
  if let newInstance = newInstance { instance = newInstance }
  return instance
}

// MARK: Custom Object Array Deserialization

public func <-- <T: Deserializable>(inout array: [T]?, dataObject: AnyObject?) -> [T]? {
  if let dataArray = convertToNilIfNull(dataObject) as? [JSONDictionary] {
    array = [T]()
    for data in dataArray {
      array!.append(T(data: data))
    }
  } else {
    array = nil
  }
  return array
}

public func <-- <T: Deserializable>(inout array: [T], dataObject: AnyObject?) -> [T] {
  var newArray: [T]?
  newArray <-- dataObject
  if let newArray = newArray { array = newArray }
  return array
}

// MARK: Custom Object Map Deserialization

public func <-- <T: Deserializable>(inout map: [String: T]?, dataObject: AnyObject?) -> [String: T]? {
  if let dataMap = convertToNilIfNull(dataObject) as? [String: JSONDictionary] {
    map = [String: T]()
    for (key, data) in dataMap {
      map![key] = T(data: data)
    }
  } else {
    map = nil
  }
  return map
}

public func <-- <T: Deserializable>(inout map: [String: T], dataObject: AnyObject?) -> [String: T] {
  var newMap: [String: T]?
  newMap <-- dataObject
  if let newMap = newMap { map = newMap }
  return map
}

// MARK: Raw Value Representable (Enum) Deserialization

public func <-- <T: RawRepresentable>(inout property: T?, value: AnyObject?) -> T? {
  var newEnumValue: T?
  var newRawEnumValue: T.RawValue?
  newRawEnumValue <-- value
  if let unwrappedNewRawEnumValue = newRawEnumValue {
    if let enumValue = T(rawValue: unwrappedNewRawEnumValue) {
      newEnumValue = enumValue
    }
  }
  property = newEnumValue
  return property
}

// For non-optionals.
public func <-- <T: RawRepresentable>(inout property: T, value: AnyObject?) -> T {
  var newValue: T?
  newValue <-- value
  if let newValue = newValue { property = newValue }
  return property
}

// MARK: JSON String Deserialization

private func dataStringToObject(dataString: String) -> AnyObject? {
  let data: NSData = dataString.dataUsingEncoding(NSUTF8StringEncoding)!
    do {
        let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        return jsonObject
    } catch {
        return nil
    }
}

public func <-- <T: Deserializable>(inout instance: T?, dataString: String) -> T? {
  return instance <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout instance: T, dataString: String) -> T {
  return instance <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout array: [T]?, dataString: String) -> [T]? {
  return array <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout array: [T], dataString: String) -> [T] {
  return array <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout map: [String: T]?, dataString: String) -> [String:T]? {
    return map <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout map: [String: T], dataString: String) -> [String:T] {
    return map <-- dataStringToObject(dataString)
}


