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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var sources = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "News App"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.isHidden = true
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(handleRefreshDataSource(_:)), for: .valueChanged)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let sourceDetail = storyboard?.instantiateViewController(withIdentifier: "SourceDetailVC")
        // navigationController?.pushViewController(sourceDetail!, animated: true)
        let source = self.sources[indexPath.row]
        let sourceDetail = SourceDetailViewController(sourceId: source["sourceId"]!, title: source["title"]!)
        navigationController?.pushViewController(sourceDetail, animated: true)
    }
    
    func loadDataSource() {
        self.activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        self.activityIndicator.backgroundColor = UIColor.white
        self.activityIndicator.bringSubview(toFront: self.view)
        self.activityIndicator.startAnimating()
        
        let provider = MoyaProvider<NewsApiService>()
        provider.request(.source) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseSources = responseJSON["sources"]
                for (key, sourceDict) in responseSources {
                    let name = sourceDict["name"]
                    let description = sourceDict["description"]
                    let sourceId = sourceDict["id"]
                    let dataSource: [String: String] = ["sourceId": "\(sourceId)", "title": "\(name)", "desc": "\(description)"]
                    self.sources.append(dataSource)
                }
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

