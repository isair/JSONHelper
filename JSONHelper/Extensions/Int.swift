//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension Int: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> Int? {
    guard let value = value else { return nil }

    if let intValue = value as? Int {
      return intValue
    } else if let stringValue = value as? String {
      return Int(stringValue)
    } else if let floatValue = value as? Float {
      return Int(floatValue)
    } else if let doubleValue = value as? Double {
      return Int(doubleValue)
    }

    throw ConversionError.unsupportedType
  }
}
