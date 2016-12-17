//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension String: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> String? {
    guard let value = value else { return nil }

    if let stringValue = value as? String {
      return stringValue
    } else if let intValue = value as? Int {
      return "\(intValue)"
    } else if let dateValue = value as? Date {
      return JSONHelper.dateFormatter.string(from: dateValue)
    }

    throw ConversionError.unsupportedType
  }
}
