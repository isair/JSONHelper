//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class NSDateTests: XCTestCase {
  let dateString = "2016-04-14"
  let dateStringFormat = "yyyy-MM-dd"
  let epochTimestamp = 1460592000

  override func setUp() {
    JSONHelper.dateFormatter.dateFormat = dateStringFormat
    JSONHelper.dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
  }

  func testEpochTimestampConversion() {
    var date = NSDate()
    date <-- (epochTimestamp as Any)
    XCTAssertEqual(JSONHelper.dateFormatter.stringFromDate(date), dateString)
  }

  func testStringConversion() {
    var date = NSDate()
    date <-- (dateString as Any)
    XCTAssertEqual(JSONHelper.dateFormatter.stringFromDate(date), dateString)
  }
}
