//
//  RedditDataModel.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/23/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import Foundation

struct RedditListing : Codable {
    let data: ListingData
}

struct ListingData : Codable {
    let children: [Post]
}

struct Post : Codable {
    let data: PostData
}

struct PostData : Codable {
    let title: String
    let subreddit_name_prefixed: String
    let url: String
}
