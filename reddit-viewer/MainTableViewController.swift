//
//  MainTableViewController.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/21/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
        
        //TODO: kick off data load
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditPostCell", for: indexPath)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let destination = segue.destination as? RedditWebViewController else { return; }
        
        destination.targetUrl = "https://www.reddit.com/r/jokes"
        // Pass the selected object to the new view controller.
    }
}
