//
//  ViewController.swift
//  RedditTest
//
//  Created by Tiago Lira on 15/03/2018.
//  Copyright © 2018 Tiago Lira. All rights reserved.
//

import UIKit
import reddift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    var list : [Subreddit] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        RedditManager.shared.getSubreddits { (list) in
            DispatchQueue.main.async {
                self.list = list ?? []
                self.table.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath)
        let item = list[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = "\(item.subscribers) subscribers"

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
        print(item)
        performSegue(withIdentifier: "toListing", sender: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListing",
            let subreddit = sender as? Subreddit,
            let controller = segue.destination as? ListViewController {
            controller.subreddit = subreddit
        }
    }
}

