//
//  TestSubmodel.swift
//  JSONHelper
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import Foundation

class TestSubmodel: Deserializable {
    var stringVal: String?

    required init(data: [String: AnyObject]) {
        stringVal <<< data["string_val"]
    }
}