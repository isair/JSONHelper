//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension Float: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> Float? {
    guard let value = value else { return nil }

    if let floatValue = value as? Float {
      return floatValue
    } else if let stringValue = value as? String {
      return Float(stringValue)
    } else if let doubleValue = value as? Double {
      return Float(doubleValue)
    } else if let intValue = value as? Int {
      return Float(intValue)
    }

    throw ConversionError.unsupportedType
  }
}
