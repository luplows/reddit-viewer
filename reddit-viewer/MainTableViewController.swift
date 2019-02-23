//
//  MainTableViewController.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/21/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RedditPostCell: UITableViewCell {
    @IBOutlet weak var subredditLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var postURL: String!
}

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var redditData: Array<RedditData> = []
    private let dataFetcher = RedditDataFetcher()
    private let disposeBag = DisposeBag()
    
    fileprivate func fetchData(_ query: String = "") {
        _ = dataFetcher.fetchJSon(query)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                if data.count != 0 {
                    self.redditData = data
                    self.tableView.reloadData()
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {[unowned self] query in
                self.fetchData(query)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditPostCell", for: indexPath)
        
        if let redditCell = cell as? RedditPostCell {
            let data = redditData[indexPath.row]
            redditCell.titleLabel.text = data.title
            redditCell.subredditLabel.text = data.subreddit
            redditCell.postURL = data.url
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RedditWebViewController else { return }
        guard let cell = sender as? RedditPostCell else { return }
        
        destination.targetUrl = cell.postURL
    }
}
