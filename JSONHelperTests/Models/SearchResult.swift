//
//  SearchResult.swift
//  JSONHelper
//
//  Created by Baris Sencan on 28/08/14.
//  Copyright (c) 2014 Baris Sencan. All rights reserved.
//

import Foundation

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