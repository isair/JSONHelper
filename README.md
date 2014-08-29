JSONHelper
==========

Lightning quick JSON deserialization for iOS &amp; OS X written in Swift. Expanded upon the ideas found in [this blog post](http://robots.thoughtbot.com/efficient-json-in-swift-with-functional-concepts-and-generics).

Purpose
--------------

There are wonderful third party libraries out there that let you get data from an API end-point easily in just a couple lines. Wouldn't it be cool if deserializing that data was always just as easy, or perhaps even easier? Well, it is with JSONHelper! The sole purpose of JSONHelper is to make deserializing super easy even when working with data with lots of optional parameters and nested objects.

__Requires iOS 7 or later.__

Installation
--------------

I plan to support [CocoaPods](http://cocoapods.org) when it starts working with Swift libraries. Until then, as a quick and easy (yet a birt dirty) method, I recommend directly adding [JSONHelper.swift](https://raw.githubusercontent.com/isair/JSONHelper/master/JSONHelper/Pod%20Classes/JSONHelper.swift) into your project.

Usage
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

You send the request using your favorite networking library and get back a response like this (of type [String: AnyObject]):

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

Deserializing this data is one line after you set up your models to use JSONHelper.

````swift
var searchResult = FriendSearchResult(data: dummyAPIResponse)
````

or as simple as:

````swift
var searchResult: FriendSearchResult?

...

searchResult <<<< dummyAPIResponse
````

And your models will only look like this after you set them up:

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
class SearchResult: Deserializable {
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

Operator List
--------------

__<<<__ Used for deserializing primitive types.

__<<<*__ Used for deserializing an array of primitive types.

__<<<<__ Used for deserializing a class.

__<<<<*__ Used for deserializing a class array.
