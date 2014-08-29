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
    let result = TestModel(data: [
        "string_val": "a",
        "int_val": 1,
        "bool_val": true,
        "string_array_val": ["a", "b", "c"],
        "int_array_val": [2, 2, 2, 2, 1],
        "bool_array_val": [true, false, true],
        "instance_val": [
            "string_val": "Mark"
        ],
        "instance_array_val": [
            [
                "string_val": "Hannibal"
            ], [
                "string_val": "Sabrina"
            ]
        ]
        ])

    // Test different deserializations.
    func testStringDeserialization() {
        XCTAssert(result.stringVal == "a", "Pass")
    }
    
    func testIntDeserialization() {
        XCTAssert(result.intVal == 1, "Pass")
    }

    func testBoolDeserialization() {
        XCTAssert(result.boolVal == true, "Pass")
    }

    func testStringArrayDeserialization() {
        XCTAssert(result.stringArrayVal?.count == 3, "Pass")
    }

    func testIntArrayDeserialization() {
        XCTAssert(result.intArrayVal?.count == 5, "Pass")
    }

    func testBoolArrayDeserialization() {
        XCTAssert(result.boolArrayVal?.count == 3, "Pass")
    }

    func testInstanceDeserialization() {
        XCTAssert(result.instanceVal?.stringVal == "Mark", "Pass")
    }

    func testInstanceArrayDeserialization() {
        XCTAssert(result.instanceArrayVal?.count == 2, "Pass")
    }
}
