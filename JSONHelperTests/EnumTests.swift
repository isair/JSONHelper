//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class EnumTests: XCTestCase {

  enum TestEnum: String {
    case Hello, Darkness, My, Old, Friend
  }

  var value = TestEnum.Hello

  override func setUp() {
    value = .Hello
  }

  func testStringConversion() {
    value <-- (TestEnum.Friend.rawValue as Any)
    XCTAssertEqual(value, TestEnum.Friend)
  }
}
