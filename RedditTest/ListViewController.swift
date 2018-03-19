//
//  ListingViewController.swift
//  RedditTest
//
//  Created by Tiago Lira on 16/03/2018.
//  Copyright © 2018 Tiago Lira. All rights reserved.
//

import UIKit
import reddift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    var subreddit : Subreddit?
    var list : [Link] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = subreddit?.title
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {
        RedditManager.shared.getLinks(subreddit: subreddit!) { (list) in
            DispatchQueue.main.async {
                self.list = list ?? []
                self.table.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let item = list[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = "\(item.score)"

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        performSegue(withIdentifier: "toLink", sender: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLink",
            let link = sender as? Link,
            let controller = segue.destination as? LinkViewController {
            controller.link = link
        }
    }

}

