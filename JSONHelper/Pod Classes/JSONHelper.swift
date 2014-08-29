//
//  JSONHelper.swift
//  JSONHelper
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
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

    if let unwrappedValue: AnyObject = value {

        if let convertedValue = unwrappedValue as? T {
            property = convertedValue
        } else {
            property = nil
        }
    } else {
        property = nil
    }

    // TODO: Error reporting support.

    return property
}

// Operator for quick primitive array deserialization.
infix operator <<<* { associativity right precedence 150 }

func <<<*(inout array: [String]?, value: AnyObject?) -> [String]? {

    if let stringArray = value >>> JSONStrings {
        array = stringArray
    } else {
        array = nil
    }

    // TODO: Error reporting support.

    return array
}

func <<<*(inout array: [Int]?, value: AnyObject?) -> [Int]? {

    if let intArray = value >>> JSONInts {
        array = intArray
    } else {
        array = nil
    }

    // TODO: Error reporting support.

    return array
}

func <<<*(inout array: [Bool]?, value: AnyObject?) -> [Bool]? {

    if let boolArray = value >>> JSONBools {
        array = boolArray
    } else {
        array = nil
    }

    // TODO: Error reporting support.

    return array
}

// Operator for quick class deserialization.
infix operator <<<< { associativity right precedence 150 }

protocol Deserializable {
    init(data: [String: AnyObject])
}

func <<<<<T: Deserializable>(inout instance: T?, dataObject: AnyObject?) -> T? {

    if let data = dataObject >>> JSONObject {
        instance = T(data: data)
    } else {
        instance = nil
    }

    // TODO: Error reporting support.

    return instance
}

// Operator for quick deserialization into an array of instances of a deserializable class.
infix operator <<<<* {associativity right precedence 150 }

func <<<<*<T: Deserializable>(inout array: [T]?, dataObject: AnyObject?) -> [T]? {

    if let dataArray = dataObject >>> JSONObjects {
        array = [T]()

        for data in dataArray {
            array!.append(T(data: data))
        }
    } else {
        array = nil
    }

    // TODO: Error reporting support.
    
    return array
}
