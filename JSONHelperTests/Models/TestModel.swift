//
//  TestModel.swift
//  JSONHelper
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import Foundation

class TestModel: Deserializable {
    var stringVal: String?
    var defaultableString = "default"
    var intVal: Int?
    var defaultableInt = 91
    var boolVal: Bool?
    var defaultableBool = true
    var stringArrayVal: [String]?
    var intArrayVal: [Int]?
    var boolArrayVal: [Bool]?
    var instanceVal: TestSubmodel?
    var instanceArrayVal: [TestSubmodel]?

    required init(data: [String : AnyObject]) {
        stringVal <<< data["string_val"]
        defaultableString <<< data["defaultable_string"]
        intVal <<< data["int_val"]
        defaultableInt <<< data["defaultable_int"]
        boolVal <<< data["bool_val"]
        defaultableBool <<< data["defaultable_bool"]
        stringArrayVal <<<* data["string_array_val"]
        intArrayVal <<<* data["int_array_val"]
        boolArrayVal <<<* data["bool_array_val"]
        instanceVal <<<< data["instance_val"]
        instanceArrayVal <<<<* data["instance_array_val"]
    }
}