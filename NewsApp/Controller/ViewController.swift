//
//  ViewController.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 1/11/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var sources = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let medium: [String: String] = ["title": "Medium", "desc": "Medium merupakan salah satu sumber artikel menarik."]
        let hackerNews: [String: String] = ["title": "Hacker News", "desc": "Hacker news, nes for hackers."]
        sources.append(medium)
        sources.append(hackerNews)
        sources.append(medium)
        sources.append(hackerNews)
        sources.append(medium)
        sources.append(hackerNews)
        sources.append(medium)
        sources.append(hackerNews)
        sources.append(medium)
        sources.append(hackerNews)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourceTableViewCell
        let data = sources[indexPath.row]
        let title = data["title"]
        cell.sourceTitle.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

