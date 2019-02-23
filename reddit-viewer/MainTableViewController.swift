//
//  MainTableViewController.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/21/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import UIKit
import RxSwift

class RedditPostCell: UITableViewCell {
    @IBOutlet weak var subredditLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var postURL: String!
}

class MainTableViewController: UITableViewController {
    
    private var redditData: Array<RedditData> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "SubredditFilterHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "subredditFilterHeaderView")
        //TODO: kick off data load
        
        _ = RedditDataFetcher.init().fetchJSon().observeOn(MainScheduler.instance).subscribe(onNext: { data in
            self.redditData = data
            self.tableView.reloadData()
        })
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "subredditFilterHeaderView")
        
        if let filterHeader = header as? SubredditFilterHeaderView {
            filterHeader.searchBar.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
        
        return header
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        print("Text changed")
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RedditWebViewController else { return }
        guard let cell = sender as? RedditPostCell else { return }
        
        destination.targetUrl = cell.postURL
    }
}
