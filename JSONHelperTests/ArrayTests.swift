//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation
import XCTest
import JSONHelper

class ArrayTests: XCTestCase {

  // MARK: - Convertable Tests

  let urlStrings = ["http://apple.com", "http://google.com", "http://facebook.com"]
  let urlHosts = ["apple.com", "google.com", "facebook.com"]

  func testArrayToConvertibleArray() {
    var urls = [URL]()
    urls <-- urlStrings

    XCTAssertEqual(urls[0].host, urlHosts[0])
    XCTAssertEqual(urls[1].host, urlHosts[1])
    XCTAssertEqual(urls[2].host, urlHosts[2])
  }

  func testArrayAsAnyToConvertibleArray() {
    var urls = [URL]()
    urls <-- (urlStrings as Any)

    XCTAssertEqual(urls[0].host, urlHosts[0])
    XCTAssertEqual(urls[1].host, urlHosts[1])
    XCTAssertEqual(urls[2].host, urlHosts[2])
  }

  // MARK: - Deserializable Tests

  struct Item: Deserializable {
    static let nameKey = "name"

    var name: String?

    init(dictionary: [String: Any]) {
      name <-- dictionary[Item.nameKey]
    }
  }

  let dictionaries = [
    [Item.nameKey : "a"],
    [Item.nameKey : "b"]
  ]

  func testArrayToDeserializableArray() {
    var items = [Item]()
    items <-- dictionaries
    XCTAssertEqual(items[0].name, "a")
    XCTAssertEqual(items[1].name, "b")
  }

  func testArrayAsAnyToDeserializableArray() {
    var items = [Item]()
    items <-- (dictionaries as Any)
    XCTAssertEqual(items[0].name, "a")
    XCTAssertEqual(items[1].name, "b")
  }
}
