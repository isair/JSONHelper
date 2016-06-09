//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension NSDate: Convertible {
  private static let sharedFormatter = NSDateFormatter()

  public static func convertFromValue<T>(value: T?) throws -> Self? {
    guard let value = value else { return nil }

    if let unixTimestamp = value as? Int {
      return self.init(timeIntervalSince1970: NSTimeInterval(unixTimestamp))
    } else if let dateString = value as? String {
      if let convertedDate = JSONHelper.dateFormatter.dateFromString(dateString) {
        return self.init(timeIntervalSince1970: convertedDate.timeIntervalSince1970)
      } else {
        throw ConversionError.InvalidValue
      }
    }

    throw ConversionError.UnsupportedType
  }
}
