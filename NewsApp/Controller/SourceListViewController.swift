//
//  ViewController.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 1/11/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift
import SwiftyJSON

class SourceListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    let disposeBag = DisposeBag()
    var sourceViewModels: BehaviorRelay<[SourceViewModel]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "News App"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.isHidden = true
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "SourceTableViewCell", bundle: nil), forCellReuseIdentifier: "SourceCell")
        
        refreshControl.addTarget(self, action: #selector(handleRefreshDataSource(_:)), for: .valueChanged)
        
        loadDataSource()
        bindRxView()
    }
    
    func bindRxView() {
        self.sourceViewModels.bind(to: self.tableView.rx.items(cellIdentifier: "SourceCell", cellType: SourceTableViewCell.self)) { row, model, cell in
            let title = model.title
            let description = model.description
            cell.sourceTitle.text = title
            cell.sourceDesc.text = description
        }
            .disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(SourceViewModel.self)
            .subscribe(onNext: { [weak self] source in
                guard let weakSelf = self else {
                    return
                }
                let articleListViewController = ArticleListViewController()
                articleListViewController._sourceId = source.id
                articleListViewController._title = source.title
                weakSelf.navigationController?.pushViewController(articleListViewController, animated: true)
            })
        .disposed(by: disposeBag)
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
                self.sourceViewModels.accept(sources)
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

