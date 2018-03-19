//
//  SessionManager.swift
//  RedditTest
//
//  Created by Tiago Lira on 15/03/2018.
//  Copyright © 2018 Tiago Lira. All rights reserved.
//

import UIKit
import reddift

class RedditManager {

    static let shared = RedditManager()
    private init() {}

    let session = Session()

    class func getSession() -> Session {
        return self.shared.session
    }

    func getSubreddits(completion: @escaping (([Subreddit]?)->())) {
        print("get subreddits")
        do {
            try session.getSubreddit(.popular, paginator: nil, completion: { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    completion(nil)
                case .success(let listing):
                    let list = listing.children.flatMap({ $0 as? Subreddit })
                    completion(list)
                }
            })
        } catch {
            print(error)
            completion(nil)
        }
    }

    func getLinks(subreddit: Subreddit, completion: @escaping (([Link]?)->())) {
        print("get list")
        do {
            try session.getList(Paginator(), subreddit: subreddit, sort: .top, timeFilterWithin: .all, completion: { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    completion(nil)
                case .success(let listing):
                    let list = listing.children.flatMap({ $0 as? Link })
                    completion(list)
                }
            })
        } catch {
            print(error)
            completion(nil)
        }
    }

    func getChildren(link: Link, completion: @escaping (([Thing]?)->())) {
        print("get list")
        do {
            try session.getArticles(link, sort: .top, completion: { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    completion(nil)
                case .success(let listing):
                    let list = listing.1.children.flatMap({ $0 as? Comment })
                    completion(list)
                }
            })
        } catch {
            print(error)
            completion(nil)
        }
    }
}
