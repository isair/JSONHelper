//
//  StringTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 6/22/15.
//  Copyright (c) 2015 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class StringTests: XCTestCase {
  let testString = "test"
  let testIntAndResult = (1, "1")
  let testDateAndResult = (Date(timeIntervalSince1970: 0), "1970-01-01")
  let testDateFormat = "yyyy-MM-dd"

  var value = ""

  override func setUp() {
    value = ""
  }

  func testStringConversion() {
    value <-- (testString as Any)
    XCTAssertEqual(value, testString)
  }

  func testIntConversion() {
    value <-- (testIntAndResult.0 as Any)
    XCTAssertEqual(value, testIntAndResult.1)
  }

  func testDateConversion() {
    JSONHelper.dateFormatter.dateFormat = testDateFormat
    JSONHelper.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

    value <-- (testDateAndResult.0 as Any)
    XCTAssertEqual(value, testDateAndResult.1)
  }
}
