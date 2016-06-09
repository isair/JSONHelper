//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension String: Convertible {

  public static func convertFromValue<T>(value: T?) throws -> String? {
    guard let value = value else { return nil }

    if let stringValue = value as? String {
      return stringValue
    } else if let intValue = value as? Int {
      return "\(intValue)"
    } else if let dateValue = value as? NSDate {
      return JSONHelper.dateFormatter.stringFromDate(dateValue)
    }

    throw ConversionError.UnsupportedType
  }
}
