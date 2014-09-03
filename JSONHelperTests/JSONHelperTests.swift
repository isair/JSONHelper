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
        XCTAssert(result.stringVal == "a", "result.stringVal should equal 'a'")
    }

    func testDefaultableString() {
        XCTAssert(result.defaultableString == "default", "result.defaultableString should equal 'default'")
        XCTAssert(resultWithChangedDefaults.defaultableString == "not default", "resultWithChangedDefaults.defaultableString should equal 'not default'")
    }
    
    func testInt() {
        XCTAssert(result.intVal == 1, "result.intVal should equal 1")
    }

    func testDefaultableInt() {
        XCTAssert(result.defaultableInt == 91, "result.defaultableInt should equal 91")
        XCTAssert(resultWithChangedDefaults.defaultableInt == 99, "resultWithChangedDefaults.defaultableInt should equal 99")
    }

    func testBool() {
        XCTAssert(result.boolVal == true, "result.boolVal should be true")
    }

    func testDefaultableBool() {
        XCTAssert(result.defaultableBool == true, "result.defaultableBool should be true")
        XCTAssert(resultWithChangedDefaults.defaultableBool == false, "resultWithChangedDefaults.defaultableBool should be false")
    }

    func testStringArray() {
        XCTAssert(result.stringArrayVal?.count == 3, "result.stringArrayVal should have 3 members")
    }

    func testIntArray() {
        XCTAssert(result.intArrayVal?.count == 5, "result.intArrayVal should have 5 members")
    }

    func testBoolArray() {
        XCTAssert(result.boolArrayVal?.count == 3, "result.boolArrayVal should have 3 members")
    }

    func testInstance() {
        XCTAssert(result.instanceVal?.stringVal == "Mark", "result.instanceVal?.stringVal should equal 'Mark'")
    }

    func testInstanceArray() {
        XCTAssert(result.instanceArrayVal?.count == 2, "result.instanceArrayVal should have 2 members")
    }
}
