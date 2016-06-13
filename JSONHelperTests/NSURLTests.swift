//
//  NSURLTests.swift
//  JSONHelper
//
//  Created by Baris Sencan on 22/01/2016.
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class NSURLTests: XCTestCase {
  let urlString = "https://facebook.com"
  let urlHost = "facebook.com"

  func testStringConversion() {
    var url = NSURL()
    url <-- (urlString as Any)
    XCTAssertEqual(url.host, urlHost)
  }
}
