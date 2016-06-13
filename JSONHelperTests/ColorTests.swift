//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import XCTest
import JSONHelper

#if os(OSX)
import AppKit
#else
import UIKit
#endif

class ColorTests: XCTestCase {
  let testStringAndResult = ("#ffffff", (r: CGFloat(1), g: CGFloat(1), b: CGFloat(1), a: CGFloat(1)))

  #if os(OSX)
  var value: NSColor?
  #else
  var value: UIColor?
  #endif

  override func setUp() {
    value = nil
  }

  func testStringConversion() {
    value <-- (testStringAndResult.0 as Any)

    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    value?.getRed(&r, green: &g, blue: &b, alpha: &a)

    XCTAssert(
      (r == testStringAndResult.1.r) && (g == testStringAndResult.1.g) && (b == testStringAndResult.1.b) && (a == testStringAndResult.1.a),
      "String to (UI/NS)Color conversion failed")
  }
}
