//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class DeserializableTests: XCTestCase {

  struct Item: Deserializable {
    static let nameKey = "name"

    var name = ""

    init(dictionary: [String : Any]) {
      name <-- dictionary[Item.nameKey]
    }

    init() {}
  }

  let itemDictionary = [Item.nameKey :  "a"]
  let itemString = "{ \"name\": \"a\" }"

  var item = Item()

  override func setUp() {
    item = Item()
  }

  func testDictionaryDeserialization() {
    item <-- itemDictionary
    XCTAssertEqual(item.name, itemDictionary[Item.nameKey])
  }

  func testStringDeserialization() {
    item <-- itemString
    XCTAssertEqual(item.name, itemDictionary[Item.nameKey])
  }
}
