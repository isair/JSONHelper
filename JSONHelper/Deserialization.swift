//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

/// TODOC
public protocol Deserializable {

  /// TODOC
  init(dictionary: [String : AnyObject]) throws
}

// MARK: - Helper Methods

private func dataStringToObject(dataString: String) -> AnyObject? {
  guard let data: NSData = dataString.dataUsingEncoding(NSUTF8StringEncoding) else { return nil }
  var jsonObject: AnyObject?
  do {
    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
  } catch {}
  return jsonObject
}

// MARK: - Basic Deserialization

public func <-- <D: Deserializable, T>(inout lhs: D?, rhs: T?) throws -> D? {
  let cleanedValue = JSONHelper.convertToNilIfNull(rhs)

  if let jsonObject = cleanedValue as? NSDictionary as? [String : AnyObject] {
    lhs = try D(dictionary: jsonObject)
  } else if let string = cleanedValue as? String {
    try lhs <-- dataStringToObject(string)
  } else {
    lhs = nil
  }
  
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: D, rhs: T?) throws -> D {
  var newValue: D?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Array Deserialization

public func <-- <D: Deserializable, T>(inout lhs: [D]?, rhs: [T]?) throws -> [D]? {
  guard let rhs = rhs else { return nil }

  lhs = [D]()
  for element in rhs {
    var convertedElement: D?
    try convertedElement <-- element
    if let convertedElement = convertedElement {
      lhs?.append(convertedElement)
    }
  }
  
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: [D], rhs: [T]?) throws -> [D] {
  var newValue: [D]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

public func <-- <D: Deserializable, T>(inout lhs: [D]?, rhs: T?) throws -> [D]? {
  guard let rhs = rhs else { return nil }

  if let elements = rhs as? NSArray as? [AnyObject] {
    return try lhs <-- elements
  }

  throw ConversionError.UnsupportedType
}

public func <-- <D: Deserializable, T>(inout lhs: [D], rhs: T?) throws -> [D] {
  var newValue: [D]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Dictionary Deserialization

public func <-- <T, D: Deserializable, U>(inout lhs: [T : D]?, rhs: [T : U]?) throws -> [T : D]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  lhs = [T : D]()
  for (key, value) in rhs {
    var convertedValue: D?
    try convertedValue <-- value
    if let convertedValue = convertedValue {
      lhs?[key] = convertedValue
    }
  }

  return lhs
}

public func <-- <T, D: Deserializable, U>(inout lhs: [T : D], rhs: [T : U]?) throws -> [T : D] {
  var newValue: [T : D]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

public func <-- <T, D: Deserializable, U>(inout lhs: [T : D]?, rhs: U?) throws -> [T : D]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  if let elements = rhs as? NSDictionary as? [T : AnyObject] {
    return try lhs <-- elements
  }

  throw ConversionError.UnsupportedType
}

public func <-- <T, D: Deserializable, U>(inout lhs: [T : D], rhs: U?) throws -> [T : D] {
  var newValue: [T : D]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}
