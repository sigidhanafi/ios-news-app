//
//  SourceDetailViewController.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 2/19/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class SourceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var _title: String?
    var _sourceId: String?
    var articles = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self._title
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        loadDataArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let data = self.articles[indexPath.row]
        let title = data["title"]
        let description = data["description"]
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func loadDataArticles() {
        let provider = MoyaProvider<NewsApiService>()
        provider.request(.source(sources: self._sourceId, pageSize: 10, page: 1)) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseArticles = responseJSON["articles"]
                for (key, articleDict) in responseArticles {
                    let title = articleDict["title"]
                    let description = articleDict["description"]
                    let dataArticle: [String: String] =  ["title": "\(title)", "description": "\(description)"]
                    self.articles.append(dataArticle)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print("ERRRR", error)
            }
        }
    }

}
