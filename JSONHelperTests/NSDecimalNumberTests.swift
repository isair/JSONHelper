//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class NSDecimalNumberTests: XCTestCase {
  let testInt = 1
  let testFloat = Float(1.2)
  let testDouble = Double(1.2)
  let testNSNumber = NSNumber(double: 1.2)
  let testNSDecimalNumber = NSDecimalNumber(double: 1.2)
  let testString = "1.2"

  var value = NSDecimalNumber(integer: 0)

  override func setUp() {
    value = NSDecimalNumber(integer: 0)
  }

  func testIntConversion() {
    value <-- (testInt as Any)
    XCTAssert(Int(value) == testInt)
  }

  func testFloatConversion() {
    value <-- (testFloat as Any)
    XCTAssertEqual(value, testNSDecimalNumber)
  }

  func testDoubleConversion() {
    value <-- (testDouble as Any)
    XCTAssertEqual(value, testNSDecimalNumber)
  }

  func testNSNumberConversion() {
    value <-- (testNSNumber as Any)
    XCTAssertEqual(value, testNSDecimalNumber)
  }

  func testNSDecimalNumberConversion() {
    value <-- (testNSDecimalNumber as Any)
    XCTAssertEqual(value, testNSDecimalNumber)
  }

  func testStringConversion() {
    value <-- (testString as Any)
    XCTAssertEqual(value, testNSDecimalNumber)
  }
}
