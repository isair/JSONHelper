//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

/// Operator for use in right hand side to left hand side conversion.
infix operator <-- : convert
precedencegroup convert
{
    associativity: right
}

/// Thrown when a conversion operation fails.
public enum ConversionError: Error {

  /// TODOC
  case unsupportedType

  /// TODOC
  case invalidValue
}

/// An object that can attempt to convert values of unknown types to its own type.
public protocol Convertible {

  /// TODOC
  static func convert<T>(fromValue value: T?) throws -> Self?
}

// MARK: - Basic Conversion

@discardableResult public func <-- <T, U>(lhs: inout T?, rhs: U?) -> T? {
  if !(lhs is NSNull) {
    lhs = JSONHelper.convertToNilIfNull(rhs) as? T
  } else {
    lhs = rhs as? T
  }
  return lhs
}

@discardableResult public func <-- <T, U>(lhs: inout T, rhs: U?) -> T {
  var newValue: T?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

@discardableResult public func <-- <C: Convertible, T>(lhs: inout C?, rhs: T?) -> C? {
  lhs = nil

  do {
    lhs = try C.convert(fromValue: JSONHelper.convertToNilIfNull(rhs))
  } catch ConversionError.invalidValue {
#if DEBUG
    print("Invalid value \(rhs.debugDescription) for supported type.")
#endif
  } catch ConversionError.unsupportedType {
#if DEBUG
    print("Unsupported type.")
#endif
  } catch {}

  return lhs
}

@discardableResult public func <-- <C: Convertible, T>(lhs: inout C, rhs: T?) -> C {
  var newValue: C?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Array Conversion

@discardableResult public func <-- <C: Convertible, T>(lhs: inout [C]?, rhs: [T]?) -> [C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  lhs = [C]()
  for element in rhs {
    var convertedElement: C?
    convertedElement <-- element

    if let convertedElement = convertedElement {
      lhs?.append(convertedElement)
    }
  }

  return lhs
}

@discardableResult public func <-- <C: Convertible, T>(lhs: inout [C], rhs: [T]?) -> [C] {
  var newValue: [C]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

@discardableResult public func <-- <C: Convertible, T>(lhs: inout [C]?, rhs: T?) -> [C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  if let elements = rhs as? NSArray as [AnyObject]? {
    return lhs <-- elements
  }

  return nil
}

@discardableResult public func <-- <C: Convertible, T>(lhs: inout [C], rhs: T?) -> [C] {
  var newValue: [C]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Dictionary Conversion

@discardableResult public func <-- <T, C: Convertible, U>(lhs: inout [T : C]?, rhs: [T : U]?) -> [T : C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  lhs = [T : C]()
  for (key, value) in rhs {
    var convertedValue: C?
    convertedValue <-- value
    if let convertedValue = convertedValue {
      lhs?[key] = convertedValue
    }
  }

  return lhs
}

@discardableResult public func <-- <T, C: Convertible, U>(lhs: inout [T : C], rhs: [T : U]?) -> [T : C] {
  var newValue: [T : C]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

@discardableResult public func <-- <T, C: Convertible, U>(lhs: inout [T : C]?, rhs: U?) -> [T : C]? {
  guard let rhs = rhs else {
    lhs = nil
    return lhs
  }

  if let elements = rhs as? NSDictionary as? [T : AnyObject] {
    return lhs <-- elements
  }

  return nil
}

@discardableResult public func <-- <T, C: Convertible, U>(lhs: inout [T : C], rhs: U?) -> [T : C] {
  var newValue: [T : C]?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}

// MARK: - Enum Conversion

@discardableResult public func <-- <T: RawRepresentable, U>(lhs: inout T?, rhs: U?) -> T? {
  var newValue: T?

  if let
    rawValue = rhs as? T.RawValue,
    let enumValue = T(rawValue: rawValue) {
    newValue = enumValue
  }
  lhs = newValue

  return lhs
}

@discardableResult public func <-- <T: RawRepresentable, U>(lhs: inout T, rhs: U?) -> T {
  var newValue: T?
  newValue <-- rhs
  lhs = newValue ?? lhs
  return lhs
}
