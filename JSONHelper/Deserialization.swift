//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

/// TODOC
public protocol Deserializable {

  /// TODOC
  init(dictionary: [String : Any])
}

// MARK: - Helper Methods

private func dataStringToObject(_ dataString: String) -> AnyObject? {
  guard let data: Data = dataString.data(using: String.Encoding.utf8) else { return nil }
  var jsonObject: Any?
  do {
    jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
  } catch {}
  return jsonObject as AnyObject?
}

// MARK: - Basic Deserialization

@discardableResult public func <-- <D: Deserializable, T>(lhs: inout D?, rhs: T?) -> D? {
  let cleanedValue = JSONHelper.convertToNilIfNull(rhs)

  if let jsonObject = cleanedValue as? NSDictionary as? [String : AnyObject] {
    lhs = D(dictionary: jsonObject)
  } else if let string = cleanedValue as? String {
    lhs <-- dataStringToObject(string)
  } else {
    lhs = nil
  }
  
  return lhs
}

@discardableResult public func <-- <D: Deserializable, T>(lhs: inout D, rhs: T?) -> D {
  var newValue: D?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Array Deserialization

@discardableResult public func <-- <D: Deserializable, T>(lhs: inout [D]?, rhs: [T]?) -> [D]? {
  guard let rhs = rhs else { return nil }

  lhs = [D]()
  for element in rhs {
    var convertedElement: D?
    convertedElement <-- element

    if let convertedElement = convertedElement {
      lhs?.append(convertedElement)
    }
  }
  
  return lhs
}

@discardableResult public func <-- <D: Deserializable, T>(lhs: inout [D], rhs: [T]?) -> [D] {
  var newValue: [D]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

@discardableResult public func <-- <D: Deserializable, T>(lhs: inout [D]?, rhs: T?) -> [D]? {
  guard let rhs = rhs else { return nil }

  if let elements = rhs as? NSArray as [AnyObject]? {
    return lhs <-- elements
  }

  return nil
}

@discardableResult public func <-- <D: Deserializable, T>(lhs: inout [D], rhs: T?) -> [D] {
  var newValue: [D]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Dictionary Deserialization

@discardableResult public func <-- <T, D: Deserializable, U>(lhs: inout [T : D]?, rhs: [T : U]?) -> [T : D]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  lhs = [T : D]()
  for (key, value) in rhs {
    var convertedValue: D?
    convertedValue <-- value

    if let convertedValue = convertedValue {
      lhs?[key] = convertedValue
    }
  }

  return lhs
}

@discardableResult public func <-- <T, D: Deserializable, U>(lhs: inout [T : D], rhs: [T : U]?) -> [T : D] {
  var newValue: [T : D]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

@discardableResult public func <-- <T, D: Deserializable, U>(lhs: inout [T : D]?, rhs: U?) -> [T : D]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  if let elements = rhs as? NSDictionary as? [T : AnyObject] {
    return lhs <-- elements
  }

  return nil
}

@discardableResult public func <-- <T, D: Deserializable, U>(lhs: inout [T : D], rhs: U?) -> [T : D] {
  var newValue: [T : D]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}
