//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension Date: Convertible {
  fileprivate static let sharedFormatter = DateFormatter()

  public static func convert<T>(fromValue value: T?) throws -> Date? {
    guard let value = value else { return nil }

    if let unixTimestamp = value as? Int {
      return self.init(timeIntervalSince1970: TimeInterval(unixTimestamp))
    } else if let dateString = value as? String {
      if let convertedDate = JSONHelper.dateFormatter.date(from: dateString) {
        return self.init(timeIntervalSince1970: convertedDate.timeIntervalSince1970)
      } else {
        throw ConversionError.invalidValue
      }
    }

    throw ConversionError.unsupportedType
  }
}
