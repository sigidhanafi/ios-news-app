//
//  ViewController.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 1/11/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var sources = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        loadDataSource()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourceTableViewCell
        let data = sources[indexPath.row]
        let title = data["title"]
        let description = data["desc"]
        cell.sourceTitle.text = title
        cell.sourceDesc.text = description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func loadDataSource() {
        let provider = MoyaProvider<NewsApiService>()
        provider.request(.source) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseSources = responseJSON["sources"]
                for (key, sourceDict) in responseSources {
                    let name = sourceDict["name"]
                    let description = sourceDict["description"]
                    let dataSource: [String: String] = ["title": "\(name)", "desc": "\(description)"]
                    self.sources.append(dataSource)
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

