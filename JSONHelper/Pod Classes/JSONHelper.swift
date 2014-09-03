//
//  JSONHelper.swift
//
//  Version 1.0.1
//
//  Created by Baris Sencan on 28/08/2014.
//  Copyright 2014 Baris Sencan
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://github.com/isair/JSONHelper
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import Foundation

// Internally used functions.
func JSONString(object: AnyObject?) -> String? {
    return object as? String
}

func JSONStrings(object: AnyObject?) -> [String]? {
    return object as? [String]
}

func JSONInt(object: AnyObject?) -> Int? {
    return object as? Int
}

func JSONInts(object: AnyObject?) -> [Int]? {
    return object as? [Int]
}

func JSONBool(object: AnyObject?) -> Bool? {
    return object as? Bool
}

func JSONBools(object: AnyObject?) -> [Bool]? {
    return object as? [Bool]
}

func JSONArray(object: AnyObject?) -> [AnyObject]? {
    return object as? [AnyObject]
}

func JSONObject(object: AnyObject?) -> [String: AnyObject]? {
    return object as? [String: AnyObject]
}

func JSONObjects(object: AnyObject?) -> [[String: AnyObject]]? {
    return object as? [[String: AnyObject]]
}

// Operator for use in "if let" conversions.
infix operator >>> { associativity left precedence 150 }

func >>><A, B>(a: A?, f: A -> B?) -> B? {

    if let x = a {
        return f(x)
    } else {
        return nil
    }
}

// Operator for quick primitive type deserialization.
infix operator <<< { associativity right precedence 150 }

func <<<<T>(inout property: T?, value: AnyObject?) -> T? {
    var didDeserialize = false

    if let unwrappedValue: AnyObject = value {

        if let convertedValue = unwrappedValue as? T {
            property = convertedValue
            didDeserialize = true
        } else {
            property = nil
        }
    } else {
        property = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return property
}

func <<<<T>(inout property: T, value: AnyObject?) -> T {
    var didDeserialize = false

    if let unwrappedValue: AnyObject = value {

        if let convertedValue = unwrappedValue as? T {
            property = convertedValue
            didDeserialize = true
        }
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return property
}

// Operator for quick primitive array deserialization.
infix operator <<<* { associativity right precedence 150 }

func <<<*(inout array: [String]?, value: AnyObject?) -> [String]? {
    var didDeserialize = false

    if let stringArray = value >>> JSONStrings {
        array = stringArray
        didDeserialize = true
    } else {
        array = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

func <<<*(inout array: [String], value: AnyObject?) -> [String] {
    var didDeserialize = false

    if let stringArray = value >>> JSONStrings {
        array = stringArray
        didDeserialize = true
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

func <<<*(inout array: [Int]?, value: AnyObject?) -> [Int]? {
    var didDeserialize = false

    if let intArray = value >>> JSONInts {
        array = intArray
        didDeserialize = true
    } else {
        array = nil
    }

    if (!didDeserialize) {
        // TODO: Error reporting support.
    }

    return array
}

func <<<*(inout array: [Int], value: AnyObject?) -> [Int] {
    var didDeserialize = false

    if let intArray = value >>> JSONInts {
        array = intArray
        didDeserialize = true
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

func <<<*(inout array: [Bool]?, value: AnyObject?) -> [Bool]? {
    var didDeserialize = false

    if let boolArray = value >>> JSONBools {
        array = boolArray
        didDeserialize = true
    } else {
        array = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

func <<<*(inout array: [Bool], value: AnyObject?) -> [Bool] {
    var didDeserialize = false

    if let boolArray = value >>> JSONBools {
        array = boolArray
        didDeserialize = true
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

// Operator for quick class deserialization.
infix operator <<<< { associativity right precedence 150 }

protocol Deserializable {
    init(data: [String: AnyObject])
}

func <<<<<T: Deserializable>(inout instance: T?, dataObject: AnyObject?) -> T? {
    var didDeserialize = false

    if let data = dataObject >>> JSONObject {
        instance = T(data: data)
        didDeserialize = true
    } else {
        instance = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return instance
}

func <<<<<T: Deserializable>(inout instance: T, dataObject: AnyObject?) -> T {
    var didDeserialize = false

    if let data = dataObject >>> JSONObject {
        instance = T(data: data)
        didDeserialize = true
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return instance
}

// Operator for quick deserialization into an array of instances of a deserializable class.
infix operator <<<<* {associativity right precedence 150 }

func <<<<*<T: Deserializable>(inout array: [T]?, dataObject: AnyObject?) -> [T]? {
    var didDeserialize = false

    if let dataArray = dataObject >>> JSONObjects {
        array = [T]()

        for data in dataArray {
            array!.append(T(data: data))
        }

        didDeserialize = true
    } else {
        array = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

func <<<<*<T: Deserializable>(inout array: [T], dataObject: AnyObject?) -> [T] {
    var didDeserialize = false

    if let dataArray = dataObject >>> JSONObjects {
        array = [T]()

        for data in dataArray {
            array.append(T(data: data))
        }

        didDeserialize = true
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }
    
    return array
}
