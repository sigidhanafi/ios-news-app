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

class SourceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var sourceViewModels = [SourceViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "News App"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.isHidden = true
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "SourceTableViewCell", bundle: nil), forCellReuseIdentifier: "SourceCell")
        
        refreshControl.addTarget(self, action: #selector(handleRefreshDataSource(_:)), for: .valueChanged)
        
        loadDataSource()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourceTableViewCell
        let data = sourceViewModels[indexPath.row]
        let title = data.title
        let description = data.description
        cell.sourceTitle.text = title
        cell.sourceDesc.text = description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceViewModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let source = self.sourceViewModels[indexPath.row]
        let sourceDetailVC = ArticleListViewController()
        sourceDetailVC._title = source.title
        sourceDetailVC._sourceId = source.id
        navigationController?.pushViewController(sourceDetailVC, animated: true)
    }
    
    func loadDataSource() {
        self.activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        self.activityIndicator.backgroundColor = UIColor.white
        self.activityIndicator.bringSubview(toFront: self.view)
        self.activityIndicator.startAnimating()
        
        let provider = MoyaProvider<NewsApiService>()
        provider.request(.sources) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseSources = responseJSON["sources"].arrayValue
                let sources = responseSources.map({ (sourceDict) -> SourceViewModel in
                    let name = sourceDict["name"].stringValue
                    let description = sourceDict["description"].stringValue
                    let sourceId = sourceDict["id"].stringValue
                    return SourceViewModel(id: "\(sourceId)", title: "\(name)", description: "\(description)")
                })
                self.sourceViewModels = sources
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func handleRefreshDataSource(_ refreshControl: UIRefreshControl) {
        self.tableView.isHidden = true
        self.loadDataSource()
        refreshControl.endRefreshing()
    }
    
}

