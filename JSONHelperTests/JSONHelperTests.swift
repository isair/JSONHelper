//
//  JSONHelperTests.swift
//  JSONHelperTests
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import UIKit
import XCTest

class JSONHelperTests: XCTestCase {
    // Initialize our test subject with a dummy API response.
    let result = SearchResult(data: [
        "query": "a",
        "current_page": 1,
        "friends_per_page": [2, 2, 2, 2, 1],
        "suggested_friend": [
            "name": "Mark",
            "age": 30
        ],
        "friends": [
            [
                "name": "Hannibal",
                "age": 76
            ], [
                "name": "Sabrina",
                "age": 18
            ]
        ]
        ])

    // Test different deserializations.
    func testStringDeserialization() {
        XCTAssert(result.query == "a", "Pass")
    }
    
    func testIntDeserialization() {
        XCTAssert(result.currentPage == 1, "Pass")
    }

    func testStringArrayDeserialization() {
        // TODO
    }

    func testIntArrayDeserialization() {
        XCTAssert(result.friendsPerPage?.count == 5, "Pass")
    }

    func testClassDeserialization() {
        XCTAssert(result.suggestedFriend?.name == "Mark", "Pass")
    }

    func testClassArrayDeserialization() {
        XCTAssert(result.friends?.count == 2, "Pass")
    }
}
