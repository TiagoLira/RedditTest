//
//  CommentsViewController.swift
//  RedditTest
//
//  Created by Tiago Lira on 16/03/2018.
//  Copyright © 2018 Tiago Lira. All rights reserved.
//

import UIKit
import reddift

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    var link : Link?
    var list : [Thing] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = link?.title
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {
        RedditManager.shared.getChildren(link: link!, completion: { (list) in
            DispatchQueue.main.async {
                self.list = list ?? []
                self.table.reloadData()
            }
        })
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        let item = list[indexPath.row] as? Comment
        cell.textLabel?.text = item?.body
        cell.detailTextLabel?.text = "\(item?.score ?? 0)"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
