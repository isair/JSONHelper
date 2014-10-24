[![Build Status](https://travis-ci.org/isair/JSONHelper.svg?branch=master)](https://travis-ci.org/isair/JSONHelper) [![Coverage Status](https://coveralls.io/repos/isair/JSONHelper/badge.png)](https://coveralls.io/r/isair/JSONHelper)

JSONHelper
==========

Lightning quick JSON deserialization for iOS &amp; OS X written in Swift. Expanded upon the ideas found in [this blog post](http://robots.thoughtbot.com/efficient-json-in-swift-with-functional-concepts-and-generics).

Table of Contents
--------------

1. [Purpose](#purpose)
2. [Installation](#installation)
3. [Operator List](#operator-list)
4. [Simple Tutorial](#simple-tutorial)
5. [Assigning Default Values](#assigning-default-values)
6. [NSDate and NSURL Deserialization](#nsdate-and-nsurl-deserialization)
7. [JSON String Deserialization](#json-string-deserialization)

Purpose
--------------

There are wonderful third party libraries out there that let you get data from an API end-point easily in just a couple lines. Wouldn't it be cool if deserializing that data was always just as easy, or perhaps even easier? Well, it is with JSONHelper! The sole purpose of JSONHelper is to make deserializing super easy even when working with data that contains lots of optional parameters and nested objects.

__Requires iOS 7 or later.__

Installation
--------------

I plan to support [CocoaPods](http://cocoapods.org) when it starts working with Swift libraries. Until then, as a quick and easy (yet a birt dirty) method, I recommend directly adding [JSONHelper.swift](https://raw.githubusercontent.com/isair/JSONHelper/master/JSONHelper/Pod%20Classes/JSONHelper.swift) into your project.

Operator List
--------------

| Operator  | Functionality                                                                                              |
| --------- | ---------------------------------------------------------------------------------------------------------- |
| __<<<__   | For deserializing data into primitive types, NSDate or NSURL.                                              |
| __<<<*__  | For deserializing data into an array of primitive types, NSDate or NSURL.                                  |
| __<<<<__  | For deserializing data into an instance of a class. __Supports JSON strings__                              |
| __<<<<*__ | For deserializing data into an array that contains instances of a certain class. __Supports JSON strings__ |

Simple Tutorial
--------------

Let's assume you have two models like the ones given below, and an api end-point where you can submit a search query to search among your friends.

```swift
class User {
    var name: String?
    var age: Int?
}
````

````swift
class FriendSearchResult {
    var currentPage: Int?
    var pageCount: Int?
    var suggestedFriend: User?
    var friends: [User]?
}
````

Let's say you send the request using your favorite networking library and get back a response like this (of type [String: AnyObject]):

````swift
let dummyAPIResponse = [
    "current_page": 1,
    "page_count": 10,
    "suggested_friend": [
        "name": "Mark",
        "age": 30
    ],
    "friends": [
        [
            "name": "Hannibal",
            "age": 76
        ], [
            "name": "Sabrina",
            "age": 18
        ]
    ]
]
````

Deserializing this data is one line after you set your models up to use JSONHelper.

````swift
var searchResult = FriendSearchResult(data: dummyAPIResponse)
````

Or if your JSON response object is of type AnyObject and you don't want to bother casting it to a [String: AnyObject], you can do the following:

````swift
var searchResult: FriendSearchResult?

...

searchResult <<<< dummyAPIResponse
````

The good thing is your models will only look like this after you set them up:

````swift
class User: Deserializable {
    var name: String?
    var age: Int?

    required init(data: [String: AnyObject]) {
        name <<< data["name"]
        age <<< data["age"]
    }
}
````

````swift
class FriendSearchResult: Deserializable {
    var currentPage: Int?
    var pageCount: Int?
    var suggestedFriend: User?
    var friends: [User]?

    required init(data: [String : AnyObject]) {
        currentPage <<< data["current_page"]
        pageCount <<< data["page_count"]
        suggestedFriend <<<< data["suggested_friend"]
        friends <<<<* data["friends"]
    }
}
````

Assigning Default Values
--------------

JSONHelper also supports non-optional deserialization, which lets you easily assign default values in case deserialization fails.

````swift
class User: Deserializable {
    var name = "Guest"

    ...

    required init(data: [String: AnyObject]) {
        name <<< data["name"]

        ...

    }
}
````

NSDate and NSURL Deserialization
--------------

The __<<<__ and __<<<*__ operators also support deserializing data into NSDate and NSURL variables.

````swift
let website: NSURL?
let imageURLs: [NSURL]?

website <<< "http://mywebsite.com"
imageURLs <<<* ["http://mywebsite.com/image.png", "http://mywebsite.com/anotherImage.png"]
````

````swift
let meetingDate: NSDate?
let partyDates: [NSDate]?

meetingDate <<< (value: "2014-09-18", format: "yyyy-MM-dd")
partyDates <<<* (value: ["2014-09-19", "2014-09-20"], format: "yyyy-MM-dd")

let myDayOff: NSDate?
myDayOff <<< 1414172803 // You can also use unix timestamps.
````

JSON String Deserialization
--------------

You can deserialize instances and arrays of instances directly from a JSON string swiftly with JSONHelper as well. Here is a quick and Groot-y example.

````swift
class Person: Deserializable {
    var name = ""

    required init(data: [String: AnyObject]) {
        name <<< data["name"]
    }
}

var jsonString = "[{\"name\": \"I am \"},{\"name\": \"Groot!\"}]"
var people = [Person]()

people <<<<* jsonString

for person in people {
    println("\(person.name)")
}
````
