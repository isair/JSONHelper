//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

open class JSONHelper {

  /// Date formatter that is used when converting strings to NSDate objects.
  open static var dateFormatter = DateFormatter()

  /// Filters out values of type NSNull.
  ///
  /// :param: value Value to check.
  ///
  /// :returns: nil if value is of type NSNull, else the value is returned as-is.
  open static func convertToNilIfNull<T>(_ value: T?) -> T? {
    return (value is NSNull) ? nil : value
  }
}
