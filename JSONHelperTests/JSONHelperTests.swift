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

    let resultWithChangedDefaults = TestModel(data: [
        "string_val": "a",
        "defaultable_string": "not default",
        "int_val": 1,
        "defaultable_int": 99,
        "bool_val": true,
        "defaultable_bool": false,
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
    func testString() {
        XCTAssert(result.stringVal == "a", "Pass")
    }

    func testDefaultableString() {
        XCTAssert(result.defaultableString == "default", "Pass")
        XCTAssert(resultWithChangedDefaults.defaultableString == "not default", "Pass")
    }
    
    func testInt() {
        XCTAssert(result.intVal == 1, "Pass")
    }

    func testDefaultableInt() {
        XCTAssert(result.defaultableInt == 91, "Pass")
        XCTAssert(resultWithChangedDefaults.defaultableInt == 99, "Pass")
    }

    func testBool() {
        XCTAssert(result.boolVal == true, "Pass")
    }

    func testDefaultableBool() {
        XCTAssert(result.defaultableBool == true, "Pass")
        XCTAssert(resultWithChangedDefaults.defaultableBool == false, "Pass")
    }

    func testStringArray() {
        XCTAssert(result.stringArrayVal?.count == 3, "Pass")
    }

    func testIntArray() {
        XCTAssert(result.intArrayVal?.count == 5, "Pass")
    }

    func testBoolArray() {
        XCTAssert(result.boolArrayVal?.count == 3, "Pass")
    }

    func testInstance() {
        XCTAssert(result.instanceVal?.stringVal == "Mark", "Pass")
    }

    func testInstanceArray() {
        XCTAssert(result.instanceArrayVal?.count == 2, "Pass")
    }
}
