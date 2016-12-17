//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension Decimal: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> Decimal? {
    guard let value = value else { return nil }

    if let doubleValue = value as? Double {
      return self.init(doubleValue)
    } else if let stringValue = value as? String {
      return self.init(string: stringValue)
    } else if let floatValue = value as? Float {
      return self.init(Double(floatValue))
    } else if let intValue = value as? Int {
      return self.init(intValue)
    }

    throw ConversionError.unsupportedType
  }
}
