//
//  RedditDataModel.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/23/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import Foundation

struct RedditListing : Codable {
    struct ListingData : Codable {
        struct Post : Codable {
            struct PostData : Codable {
                let title: String
                let subreddit_name_prefixed: String
                let url: String
            }
            let kind: String
            let data: PostData
        }
        let modhash: String
        let dist: Int
        let children: [Post]
        let after: String
        let before: String?
    }
    
    let kind: String
    let data: ListingData
    
}
