//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class DateTests: XCTestCase {
  let dateString = "2016-04-14"
  let dateStringFormat = "yyyy-MM-dd"
  let epochTimestamp = 1460592000

  override func setUp() {
    JSONHelper.dateFormatter.dateFormat = dateStringFormat
    JSONHelper.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
  }

  func testEpochTimestampConversion() {
    var date = Date()
    date <-- (epochTimestamp as Any)
    XCTAssertEqual(JSONHelper.dateFormatter.string(from: date), dateString)
  }

  func testStringConversion() {
    var date = Date()
    date <-- (dateString as Any)
    XCTAssertEqual(JSONHelper.dateFormatter.string(from: date), dateString)
  }
}
