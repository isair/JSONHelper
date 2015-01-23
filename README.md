
JSONHelper
==========
[![Build Status](https://travis-ci.org/isair/JSONHelper.svg?branch=master)](https://travis-ci.org/isair/JSONHelper)
[![Stories in Ready](https://badge.waffle.io/isair/JSONHelper.png?label=ready&title=Ready)](https://waffle.io/isair/JSONHelper)
[![Gitter](https://badges.gitter.im/JOIN CHAT.svg)](https://gitter.im/isair/JSONHelper?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Support via Gratipay](https://cdn.rawgit.com/gratipay/gratipay-badge/2.3.0/dist/gratipay.png)](https://gratipay.com/bsencan91/)

Lightning fast JSON deserialization for iOS &amp; OS X written in Swift. Expanded upon the ideas found in [this blog post](http://robots.thoughtbot.com/efficient-json-in-swift-with-functional-concepts-and-generics).

Table of Contents
--------------

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Operator List](#operator-list)
4. [Simple Tutorial](#simple-tutorial)
5. [Assigning Default Values](#assigning-default-values)
6. [NSDate and NSURL Deserialization](#nsdate-and-nsurl-deserialization)
7. [JSON String Deserialization](#json-string-deserialization)

Introduction
--------------

JSONHelper is a library written to make sure that deserializing data obtained from an API is as easy as possible. It doesn't depend on any networking libraries, and works equally well with any of them.

__Requires iOS 7 or later and Xcode 6.1+__

Installation
--------------

I plan to support [CocoaPods](http://cocoapods.org) when it starts working with Swift libraries. Until then, as a quick and easy (yet a bit dirty) method, I recommend directly adding [JSONHelper.swift](https://raw.githubusercontent.com/isair/JSONHelper/master/JSONHelper/JSONHelper.swift) into your project.

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

Please take a good look at the operator list before you start reading this tutorial. Also, for simplicity, I'm going to assume you use [AFNetworking](https://github.com/AFNetworking/AFNetworking) as your networking library. Let's say we have an endpoint at __http://yoursite.com/your-endpoint/__ which gives the following response when a simple __GET__ request is sent to it.

```json
{
	"books": [
		{
			"author": "Irvine Welsh",
			"name": "Filth"		
		},
		{
			"author": "Bret Easton Ellis",
			"name": "American Psycho"
		}	
	]
}
```

From this response it is clear that we have a book model similar to the implementation below.

```swift
class Book {
	var author: String?
	var name: String?
}
```

We now have to make it extend the protocol __Deserializable__ and implement the __required init(data: [String: AnyObject])__ initializer. The complete model should look like this:

```swift
class Book: Deserializable {
	var author: String? // You can also use let instead of var if you want.
	var name: String?
	
	required init(data: [String: AnyObject]) {
		author <<< data["author"]
		name <<< data["name"]
	}
}
```

And finally, requesting and deserializing the response from our endpoint becomes as easy as the following piece of code.

```swift
AFHTTPRequestOperationManager().GET(
	"http://yoursite.com/your-endpoint/"
	parameters: nil,
	success: { operation, data in
		var books: [Book]?
		books <<<<* data["books"]
		
		if let books = books {
			// Response contained a books array, and we deserialized it. Do what you want here.
		} else {
			// Server gave us a response but there was no books key in it, so the books variable
			// is equal to nil. Do some error handling here.
		}
	},
	failure: { operation, error in
		// Handle error.
})
```

Assigning Default Values
--------------

You can easily assign default values to variables in cases where you want them to have a certain value when deserialization fails.

````swift
class User: Deserializable {
    var name = "Guest"

    required init(data: [String: AnyObject]) {
        name <<< data["name"]
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

You can deserialize instances and arrays of instances directly from a JSON string as well. Here is a quick example.

````swift
class Person: Deserializable {
    var name = ""

    required init(data: [String: AnyObject]) {
        name <<< data["name"]
    }
}

var jsonString = "[{\"name\": \"Rocket Raccoon\"}, {\"name\": \"Groot\"}]"
var people = [Person]()

people <<<<* jsonString

for person in people {
    println("\(person.name)")
}
````
