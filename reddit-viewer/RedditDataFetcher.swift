//
//  RedditDataFetcher.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/21/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct RedditData {
    let subreddit: String
    let title: String
    let url: String
}

class RedditDataFetcher: NSObject {
    
    public func fetchJSon(subreddit: String? = nil) -> Observable<Array<RedditData>> {
        
        return Observable.create({ observer in
            let req = URLRequest.init(url: URL.init(string: "http://reddit.com/.json")!)
            
            let responseJSON = URLSession.shared.rx.json(request: req)
            
            let cancel = Disposables.create {
                //todo: cancel request
            }
            
            _ = responseJSON
                .subscribe(onNext: { json in
                    let Posts = self.parseJson(json: json)
                    observer.on(.next(Posts))
                })
            
            return cancel
            })
    }
    
    private func parseJson(json: Any) -> Array<RedditData> {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(RedditListing.self, from: data)
            return decoded.data.children.map({ post in
                let postData = post.data
                return RedditData.init(subreddit: postData.subreddit_name_prefixed, title: postData.title, url: postData.url)
            })
        } catch {
            return []
        }
    }
}
