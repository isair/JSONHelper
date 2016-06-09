//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class DoubleTests: XCTestCase {
  let testInt = 1
  let testFloat = Float(1.2)
  let testDouble = Double(1.2)
  let testNSNumber = NSNumber(double: 1.2)
  let testNSDecimalNumber = NSDecimalNumber(double: 1.2)
  let testString = "1.2"

  var value = 0.0

  override func setUp() {
    value = 0.0
  }

  func testIntConversion() {
    try! value <-- (testInt as Any)
    XCTAssert(Int(value) == testInt)
  }

  func testFloatConversion() {
    try! value <-- (testFloat as Any)
    XCTAssertEqual(value, testDouble)
  }

  func testDoubleConversion() {
    try! value <-- (testDouble as Any)
    XCTAssertEqual(value, testDouble)
  }

  func testNSNumberConversion() {
    try! value <-- (testNSNumber as Any)
    XCTAssertEqual(value, testDouble)
  }

  func testNSDecimalNumberConversion() {
    try! value <-- (testNSDecimalNumber as Any)
    XCTAssertEqual(value, testDouble)
  }

  func testStringConversion() {
    try! value <-- (testString as Any)
    XCTAssertEqual(value, testDouble)
  }
}
