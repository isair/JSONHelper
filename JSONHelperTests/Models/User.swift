//
//  User.swift
//  JSONHelper
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import Foundation

class User: Deserializable {
    var name: String?
    var age: Int?

    required init(data: [String: AnyObject]) {
        name <<< data["name"]
        age <<< data["age"]
    }
}