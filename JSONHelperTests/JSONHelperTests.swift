//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class JSONHelperTests: XCTestCase {

  func testConvertToNilIfNull() {
    let nilValues: [AnyObject?] = [NSNull(), nil]
    let nonNilValues = [0, "", false, [], [:]] as [Any]

    for nilValue in nilValues {
      XCTAssert(JSONHelper.convertToNilIfNull(nilValue) == nil)
    }

    for nonNilValue in nonNilValues {
      XCTAssert(JSONHelper.convertToNilIfNull(nonNilValue) != nil)
    }
  }
}
