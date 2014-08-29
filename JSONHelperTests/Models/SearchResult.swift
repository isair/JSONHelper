//
//  SearchResult.swift
//  JSONHelper
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import Foundation

class SearchResult: Deserializable {
    var query: String?
    var currentPage: Int?
    var friendsPerPage: [Int]?
    var suggestedFriend: User?
    var friends: [User]?

    required init(data: [String : AnyObject]) {
        query <<< data["query"]
        currentPage <<< data["current_page"]
        friendsPerPage <<<* data["friends_per_page"]
        suggestedFriend <<<< data["suggested_friend"]
        friends <<<<* data["friends"]
    }
}