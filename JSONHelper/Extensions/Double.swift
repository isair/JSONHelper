//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension Double: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> Double? {
    guard let value = value else { return nil }

    if let doubleValue = value as? Double {
      return doubleValue
    } else if let stringValue = value as? String {
      return Double(stringValue)
    } else if let floatValue = value as? Float {
      return Double(floatValue)
    } else if let intValue = value as? Int {
      return Double(intValue)
    }

    throw ConversionError.unsupportedType
  }
}
