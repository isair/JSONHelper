//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

private struct ColorConversionHelper {

  fileprivate static func hexStringToRGBA(_ hexString: String) throws -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var red   = CGFloat(0)
    var green = CGFloat(0)
    var blue  = CGFloat(0)
    var alpha = CGFloat(1)

    if hexString.hasPrefix("#") {
      let index    = hexString.characters.index(hexString.startIndex, offsetBy: 1)
      let hex      = hexString.substring(from: index)
      let scanner  = Scanner(string: hex)
      var hexValue = CUnsignedLongLong(0)

      if scanner.scanHexInt64(&hexValue) {
        switch (hex.characters.count) {
        case 3:
          red   = CGFloat((hexValue & 0xF00) >> 8) / 15.0
          green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
          blue  = CGFloat(hexValue  & 0x00F)       / 15.0
        case 4:
          red   = CGFloat((hexValue & 0xF000) >> 12) / 15.0
          green = CGFloat((hexValue & 0x0F00) >> 8)  / 15.0
          blue  = CGFloat((hexValue & 0x00F0) >> 4)  / 15.0
          alpha = CGFloat(hexValue  & 0x000F)        / 15.0
        case 6:
          red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
          green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
          blue  = CGFloat(hexValue  & 0x0000FF)        / 255.0
        case 8:
          red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
          green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
          blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
          alpha = CGFloat(hexValue  & 0x000000FF)        / 255.0
        default:
          throw ConversionError.invalidValue
        }
      }
    }
    return (red: red, green: green, blue: blue, alpha: alpha)
  }
}

#if os(OSX)

import AppKit

extension NSColor: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> Self? {
    guard let value = value else { return nil }

    if let stringValue = value as? String {
      let rgba = try ColorConversionHelper.hexStringToRGBA(stringValue)
      return self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }

    throw ConversionError.unsupportedType
  }
}

#else

import UIKit

extension UIColor: Convertible {

  public static func convert<T>(fromValue value: T?) throws -> Self? {
    guard let value = value else { return nil }

    if let stringValue = value as? String {
      let rgba = try ColorConversionHelper.hexStringToRGBA(stringValue)
      return self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }

    throw ConversionError.unsupportedType
  }
}

#endif
