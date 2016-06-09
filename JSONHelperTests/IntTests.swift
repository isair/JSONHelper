//
//  IntTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 6/29/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class IntTests: XCTestCase {
  let testInt = 1
  let testFloat = Float(1)
  let testDouble = Double(1)
  let testNSNumber = NSNumber(integer: 1)
  let testNSDecimalNumber = NSDecimalNumber(integer: 1)
  let testString = "1"

  var value = 0

  override func setUp() {
    value = 0
  }

  func testIntConversion() {
    try! value <-- (testInt as Any)
    XCTAssertEqual(value, testInt)
  }

  func testFloatConversion() {
    try! value <-- (testFloat as Any)
    XCTAssertEqual(value, testInt)
  }

  func testDoubleConversion() {
    try! value <-- (testDouble as Any)
    XCTAssertEqual(value, testInt)
  }

  func testNSNumberConversion() {
    try! value <-- (testNSNumber as Any)
    XCTAssertEqual(value, testInt)
  }

  func testNSDecimalNumberConversion() {
    try! value <-- (testNSDecimalNumber as Any)
    XCTAssertEqual(value, testInt)
  }

  func testStringConversion() {
    try! value <-- (testString as Any)
    XCTAssertEqual(value, testInt)
  }
}
