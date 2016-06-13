//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class BoolTests: XCTestCase {
  let testBool = true
  let testIntsAndResults = [(-1, false), (0, false), (1, true), (2, true)]
  let testStringsAndResults = [("true", true), ("t", true), ("false", false), ("f", false), ("yes", true), ("y", true), ("no", false), ("n", false)]

  var value: Bool?

  override func setUp() {
    value = nil
  }

  func testBoolConversion() {
    value <-- (testBool as Any)
    XCTAssertEqual(value, testBool)
  }

  func testIntConversion() {
    for intAndResult in testIntsAndResults {
      value <-- (intAndResult.0 as Any)
      XCTAssertEqual(value, intAndResult.1)
    }
  }

  func testStringConversion() {
    for stringAndResult in testStringsAndResults {
      value <-- (stringAndResult.0 as Any)
      XCTAssertEqual(value, stringAndResult.1)
    }
  }
}
