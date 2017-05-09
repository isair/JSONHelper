//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class DecimalTests: XCTestCase {
  let testInt = 1
  let testFloat = Float(1.5)
  let testDouble = Double(1.5)
  let testDecimal = Decimal(1.5)
  let testNSNumber = NSNumber(value: 1.5 as Double)
  let testNSDecimalNumber = NSDecimalNumber(value: 1.5 as Double)
  let testString = "1.5"

  var value = Decimal(0)

  override func setUp() {
    value = Decimal(0)
  }

  func testIntConversion() {
    value <-- (testInt as Any)
    XCTAssertEqual(Int(NSDecimalNumber(decimal: value)), testInt)
  }

  func testFloatConversion() {
    value <-- (testFloat as Any)
    XCTAssertEqual(value, testDecimal)
  }

  func testDoubleConversion() {
    value <-- (testDouble as Any)
    XCTAssertEqual(value, testDecimal)
  }

  func testNSNumberConversion() {
    value <-- (testNSNumber as Any)
    XCTAssertEqual(value, testDecimal)
  }

  func testNSDecimalNumberConversion() {
    value <-- (testNSDecimalNumber as Any)
    XCTAssertEqual(value, testDecimal)
  }

  func testStringConversion() {
    value <-- (testString as Any)
    XCTAssertEqual(value, testDecimal)
  }
}
