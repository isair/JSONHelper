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
    var dateVal: NSDate?
    var defaultableDate = NSDate()
    var urlVal: NSURL?
    var defaultableURL = NSURL(string: "http://google.com/")!
    var stringArrayVal: [String]?
    var intArrayVal: [Int]?
    var boolArrayVal: [Bool]?
    var dateArrayVal: [NSDate]?
    var urlArrayVal: [NSURL]?
    var instanceVal: TestSubmodel?
    var instanceArrayVal: [TestSubmodel]?

    required init(data: [String : AnyObject]) {
        stringVal <<< data["string_val"]
        defaultableString <<< data["defaultable_string"]
        intVal <<< data["int_val"]
        defaultableInt <<< data["defaultable_int"]
        boolVal <<< data["bool_val"]
        defaultableBool <<< data["defaultable_bool"]
        dateVal <<< (value: data["date_val"], format: "yyyy-MM-dd")
        defaultableDate <<< (value: data["defaultable_date"], format: "yyyy-MM-dd")
        urlVal <<< data["url_val"]
        defaultableURL <<< data["defaultable_url"]
        stringArrayVal <<<* data["string_array_val"]
        intArrayVal <<<* data["int_array_val"]
        boolArrayVal <<<* data["bool_array_val"]
        dateArrayVal <<<* (value: data["date_array_val"], format: "yyyy-MM-dd")
        urlArrayVal <<<* data["url_array_val"]
        instanceVal <<<< data["instance_val"]
        instanceArrayVal <<<<* data["instance_array_val"]
    }
}