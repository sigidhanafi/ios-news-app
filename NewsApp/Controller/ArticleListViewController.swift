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

class ArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var _title: String?
    var _sourceId: String?
    var articleViewModels = [ArticleViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self._title
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.isHidden = true
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        
        refreshControl.addTarget(self, action: #selector(handleRefreshDataArticles(_:)), for: .valueChanged)
        
        loadDataArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let data = self.articleViewModels[indexPath.row]
        let title = data.title
        let description = data.description
        let imageUrl = data.imageUrl
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        
        if let url = URL(string: imageUrl) {
            downloadImage(url: url, onComplete: { (data) in
                let image = UIImage(data: data)
                cell.articleImage.image = image
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    func loadDataArticles() {
        self.activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.backgroundColor = UIColor.white
        self.activityIndicator.bringSubview(toFront: self.view)
        self.activityIndicator.startAnimating()
        
        let provider = MoyaProvider<NewsApiService>()
        provider.request(.source(sources: self._sourceId, pageSize: 10, page: 1)) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseArticles = responseJSON["articles"].arrayValue
                let articles = responseArticles.map({ (articleDict) -> ArticleViewModel in
                    let title = articleDict["title"].stringValue
                    let description = articleDict["description"].stringValue
                    let imageUrl = articleDict["urlToImage"].stringValue
                    return ArticleViewModel(title: "\(title)", description: "\(description)", imageUrl: "\(imageUrl)")
                })
                self.articleViewModels = articles
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print("ERRRR", error)
            }
        }
    }
    
    @objc private func handleRefreshDataArticles(_ refreshControl: UIRefreshControl) {
        self.tableView.isHidden = true
        self.loadDataArticles()
        refreshControl.endRefreshing()
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    func downloadImage(url: URL, onComplete: @escaping ((Data) -> Void)) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data else { return }
            onComplete(data)
        }
    }

}
