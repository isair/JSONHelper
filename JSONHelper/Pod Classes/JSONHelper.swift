//
//  JSONHelper.swift
//
//  Version 1.3.0
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
public func JSONString(object: AnyObject?) -> String? {
    return object as? String
}

public func JSONStrings(object: AnyObject?) -> [String]? {
    return object as? [String]
}

public func JSONInt(object: AnyObject?) -> Int? {
    return object as? Int
}

public func JSONInts(object: AnyObject?) -> [Int]? {
    return object as? [Int]
}

public func JSONBool(object: AnyObject?) -> Bool? {
    return object as? Bool
}

public func JSONBools(object: AnyObject?) -> [Bool]? {
    return object as? [Bool]
}

public func JSONArray(object: AnyObject?) -> [AnyObject]? {
    return object as? [AnyObject]
}

public func JSONObject(object: AnyObject?) -> [String: AnyObject]? {
    return object as? [String: AnyObject]
}

public func JSONObjects(object: AnyObject?) -> [[String: AnyObject]]? {
    return object as? [[String: AnyObject]]
}

// Operator for use in "if let" conversions.
infix operator >>> { associativity left precedence 150 }

public func >>><A, B>(a: A?, f: A -> B?) -> B? {

    if let x = a {
        return f(x)
    } else {
        return nil
    }
}

// Operator for quick primitive type deserialization.
infix operator <<< { associativity right precedence 150 }

public func <<<<T>(inout property: T?, value: AnyObject?) -> T? {
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

public func <<<<T>(inout property: T, value: AnyObject?) -> T {
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

public func <<<(inout property: NSURL?, value: AnyObject?) -> NSURL? {
    var didDeserialize = false

    if let stringURL = value >>> JSONString {
        property = NSURL(string: stringURL)
        didDeserialize = true
    } else {
        property = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return property
}

public func <<<(inout property: NSURL, value: AnyObject?) -> NSURL {
    var didDeserialize = false

    if let stringURL = value >>> JSONString {
        property = NSURL(string: stringURL)
        didDeserialize = true
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return property
}

public func <<<(inout property: NSDate?, valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> NSDate? {
    var didDeserialize = false

    if let dateString = valueAndFormat.value >>> JSONString {

        if let formatString = valueAndFormat.format >>> JSONString {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = formatString

            if let newDate = dateFormatter.dateFromString(dateString) {
                property = newDate
                didDeserialize = true
            } else {
                property = nil
            }
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

public func <<<(inout property: NSDate, valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> NSDate {
    var didDeserialize = false

    if let dateString = valueAndFormat.value >>> JSONString {

        if let formatString = valueAndFormat.format >>> JSONString {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = formatString

            if let newDate = dateFormatter.dateFromString(dateString) {
                property = newDate
                didDeserialize = true
            }
        }
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }
    
    return property
}

// Internal function to convert from NSNumber -> NSDate
internal func dateFromSecondsSince1970(t: NSNumber) -> NSDate {
    return NSDate(timeIntervalSince1970: t.doubleValue)
}

// Overrides for <<< which creates a date from a JSON number assuming the
// number represents unix time (seconds since Jan 1, 1970)
public func <<<(inout property: NSDate?, value: AnyObject?) -> NSDate? {
    return property <<< (value, dateFromSecondsSince1970)
}

public func <<<(inout property: NSDate, value: AnyObject?) -> NSDate {
    return property <<< (value, dateFromSecondsSince1970)
}

// Override for <<< which creates a date from a JSON number and allows the
// caller to specify a function which provides the conversion from NSNumber to NSDate.
public func <<<(inout property: NSDate?, valueAndConverter: (value: AnyObject?, converter: (NSNumber) -> NSDate)) -> NSDate? {
    var didDeserialize = false
    
    if let unwrappedValue: AnyObject = valueAndConverter.value {
        
        if let convertedValue = unwrappedValue as? NSNumber {
            property = valueAndConverter.converter(convertedValue)
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

public func <<<(inout property: NSDate, valueAndConverter: (value: AnyObject?, converter: (NSNumber) -> NSDate)) -> NSDate {
    var didDeserialize = false
    
    if let unwrappedValue: AnyObject = valueAndConverter.value {
        
        if let convertedValue = unwrappedValue as? NSNumber {
            property = valueAndConverter.converter(convertedValue)
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

public func <<<*(inout array: [String]?, value: AnyObject?) -> [String]? {
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

public func <<<*(inout array: [String], value: AnyObject?) -> [String] {
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

public func <<<*(inout array: [Int]?, value: AnyObject?) -> [Int]? {
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

public func <<<*(inout array: [Int], value: AnyObject?) -> [Int] {
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

public func <<<*(inout array: [Bool]?, value: AnyObject?) -> [Bool]? {
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

public func <<<*(inout array: [Bool], value: AnyObject?) -> [Bool] {
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

public func <<<*(inout array: [NSURL]?, value: AnyObject?) -> [NSURL]? {
    var didDeserialize = false

    if let stringURLArray = value >>> JSONStrings {
        array = [NSURL]()
        didDeserialize = true

        for stringURL in stringURLArray {
            array!.append(NSURL(string: stringURL))
        }
    } else {
        array = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

public func <<<*(inout array: [NSURL], value: AnyObject?) -> [NSURL] {
    var didDeserialize = false

    if let stringURLArray = value >>> JSONStrings {
        array = [NSURL]()
        didDeserialize = true

        for stringURL in stringURLArray {
            array.append(NSURL(string: stringURL))
        }
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

public func <<<*(inout array: [NSDate]?, valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> [NSDate]? {
    var didDeserialize = false

    if let dateStringArray = valueAndFormat.value >>> JSONStrings {

        if let formatString = valueAndFormat.format >>> JSONString {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = formatString

            array = [NSDate]()
            didDeserialize = true

            for dateString in dateStringArray {

                if let date = dateFormatter.dateFromString(dateString) {
                    array!.append(date)
                }
            }
        } else {
            array = nil
        }
    } else {
        array = nil
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }

    return array
}

public func <<<*(inout array: [NSDate], valueAndFormat: (value: AnyObject?, format: AnyObject?)) -> [NSDate] {
    var didDeserialize = false

    if let dateStringArray = valueAndFormat.value >>> JSONStrings {

        if let formatString = valueAndFormat.format >>> JSONString {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = formatString

            array = [NSDate]()
            didDeserialize = true

            for dateString in dateStringArray {

                if let date = dateFormatter.dateFromString(dateString) {
                    array.append(date)
                }
            }
        }
    }

    if !didDeserialize {
        // TODO: Error reporting support.
    }
    
    return array
}

// Operator for quick class deserialization.
infix operator <<<< { associativity right precedence 150 }

public protocol Deserializable {
    init(data: [String: AnyObject])
}

public func <<<<<T: Deserializable>(inout instance: T?, dataObject: AnyObject?) -> T? {
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

public func <<<<<T: Deserializable>(inout instance: T, dataObject: AnyObject?) -> T {
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

public func <<<<*<T: Deserializable>(inout array: [T]?, dataObject: AnyObject?) -> [T]? {
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

public func <<<<*<T: Deserializable>(inout array: [T], dataObject: AnyObject?) -> [T] {
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

// Overloading of own operators for deserialization of JSON strings.
private func dataStringToObject(dataString: String) -> AnyObject? {
    var data: NSData = dataString.dataUsingEncoding(NSUTF8StringEncoding)!
    var error: NSError?

    return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
}

public func <<<<<T: Deserializable>(inout instance: T?, dataString: String) -> T? {
    return instance <<<< dataStringToObject(dataString)
}

public func <<<<<T: Deserializable>(inout instance: T, dataString: String) -> T {
    return instance <<<< dataStringToObject(dataString)
}

public func <<<<*<T: Deserializable>(inout array: [T]?, dataString: String) -> [T]? {
    return array <<<<* dataStringToObject(dataString)
}

public func <<<<*<T: Deserializable>(inout array: [T], dataString: String) -> [T] {
    return array <<<<* dataStringToObject(dataString)
}

