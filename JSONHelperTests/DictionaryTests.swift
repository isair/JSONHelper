//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class DictionaryTests: XCTestCase {

  // MARK: - Convertible Tests

  let dateStringDictionary = ["one" : "2014-11-02", "two" : "2015-04-24"]

  override func setUp() {
    JSONHelper.dateFormatter.dateFormat = "yyyy-MM-dd"
  }

  func testDictionaryToConvertibleDictionary() {
    var value = [String : Date]()
    value <-- dateStringDictionary
    XCTAssertEqual(JSONHelper.dateFormatter.string(from: value["one"]!), dateStringDictionary["one"])
  }

  func testDictionaryAsAnyToConvertibleDictionary() {
    var value = [String : Date]()
    value <-- (dateStringDictionary as Any)
    XCTAssertEqual(JSONHelper.dateFormatter.string(from: value["one"]!), dateStringDictionary["one"])
  }

  // MARK: - Deserializable Tests

  let dictionary = [
    "one" : ["name" : "a"],
    "two" : ["name" : "b"]
  ]

  struct Item: Deserializable {
    static let nameKey = "name"

    var name = ""

    init(dictionary: [String : Any]) {
      name <-- dictionary["name"]
    }
  }

  func testDictionaryToMappableDictionary() {
    var value = [String : Item]()
    value <-- dictionary
    XCTAssertEqual(value["one"]?.name, dictionary["one"]?["name"])
    XCTAssertEqual(value["two"]?.name, dictionary["two"]?["name"])
  }

  func testDictionaryAsAnyToMappableDictionary() {
    var value = [String : Item]()
    value <-- (dictionary as Any)
    XCTAssertEqual(value["one"]?.name, dictionary["one"]?["name"])
    XCTAssertEqual(value["two"]?.name, dictionary["two"]?["name"])
  }
}
