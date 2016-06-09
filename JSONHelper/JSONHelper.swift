//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

public class JSONHelper {

  /// Date formatter that is used when converting strings to NSDate objects.
  public static var dateFormatter = NSDateFormatter()

  /// Filters out values of type NSNull.
  ///
  /// :param: value Value to check.
  ///
  /// :returns: nil if value is of type NSNull, else the value is returned as-is.
  public static func convertToNilIfNull<T>(value: T?) -> T? {
    return (value is NSNull) ? nil : value
  }
}
