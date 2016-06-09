//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

/// Operator for use in right hand side to left hand side conversion.
infix operator <-- { associativity right precedence 150 }

/// Thrown when a conversion operation fails.
public enum ConversionError: ErrorType {

  /// TODOC
  case UnsupportedType

  /// TODOC
  case InvalidValue
}

/// An object that can attempt to convert values of unknown types to its own type.
public protocol Convertible {

  /// TODOC
  static func convertFromValue<T>(value: T?) throws -> Self?
}

// MARK: - Basic Conversion

public func <-- <T, U>(inout lhs: T?, rhs: U?) throws -> T? {
  if !(lhs is NSNull) {
    lhs = JSONHelper.convertToNilIfNull(rhs) as? T
  } else {
    lhs = rhs as? T
  }
  return lhs
}

public func <-- <T, U>(inout lhs: T, rhs: U?) throws -> T {
  var newValue: T?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: C?, rhs: T?) throws -> C? {
  lhs = try C.convertFromValue(JSONHelper.convertToNilIfNull(rhs))
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: C, rhs: T?) throws -> C {
  var newValue: C?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Array Conversion

public func <-- <C: Convertible, T>(inout lhs: [C]?, rhs: [T]?) throws -> [C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  lhs = [C]()
  for element in rhs {
    var convertedElement: C?
    try convertedElement <-- element
    if let convertedElement = convertedElement {
      lhs?.append(convertedElement)
    }
  }

  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [C], rhs: [T]?) throws -> [C] {
  var newValue: [C]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

public func <-- <C: Convertible, T>(inout lhs: [C]?, rhs: T?) throws -> [C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  if let elements = rhs as? NSArray as? [AnyObject] {
    return try lhs <-- elements
  }

  throw ConversionError.UnsupportedType
}

public func <-- <C: Convertible, T>(inout lhs: [C], rhs: T?) throws -> [C] {
  var newValue: [C]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Dictionary Conversion

public func <-- <T, C: Convertible, U>(inout lhs: [T : C]?, rhs: [T : U]?) throws -> [T : C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  lhs = [T : C]()
  for (key, value) in rhs {
    var convertedValue: C?
    try convertedValue <-- value
    if let convertedValue = convertedValue {
      lhs?[key] = convertedValue
    }
  }

  return lhs
}

public func <-- <T, C: Convertible, U>(inout lhs: [T : C], rhs: [T : U]?) throws -> [T : C] {
  var newValue: [T : C]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

public func <-- <T, C: Convertible, U>(inout lhs: [T : C]?, rhs: U?) throws -> [T : C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  if let elements = rhs as? NSDictionary as? [T : AnyObject] {
    return try lhs <-- elements
  }

  throw ConversionError.UnsupportedType
}

public func <-- <T, C: Convertible, U>(inout lhs: [T : C], rhs: U?) throws -> [T : C] {
  var newValue: [T : C]?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Enum Conversion

public func <-- <T: RawRepresentable, U>(inout lhs: T?, rhs: U?) throws -> T? {
  var newValue: T?

  if let
    rawValue = rhs as? T.RawValue,
    enumValue = T(rawValue: rawValue) {
    newValue = enumValue
  }
  lhs = newValue

  return lhs
}

public func <-- <T: RawRepresentable, U>(inout lhs: T, rhs: U?) throws -> T {
  var newValue: T?
  try newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}
