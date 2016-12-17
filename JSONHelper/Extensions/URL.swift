//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

extension URL: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> URL? {
    guard let value = value else { return nil }

    if let urlValue = value as? URL {
      return self.init(string: urlValue.absoluteString)
    } else if let stringValue = value as? String {
      return self.init(string: stringValue)
    }

    throw ConversionError.unsupportedType
  }
}
