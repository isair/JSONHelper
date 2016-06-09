//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension NSURL: Convertible {

  public static func convertFromValue<T>(value: T?) throws -> Self? {
    guard let value = value else { return nil }

    if let urlValue = value as? NSURL {
      return self.init(string: urlValue.absoluteString)
    } else if let stringValue = value as? String {
      return self.init(string: stringValue)
    }

    throw ConversionError.UnsupportedType
  }
}
