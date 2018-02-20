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

class SourceDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    private var _title: String?
    private var _sourceId: String?
    
    
    init(sourceId: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        _sourceId = sourceId
        _title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = self._title
        self.navigationItem.title = self._title
        
        let provider = MoyaProvider<NewsApiService>()
        provider.request(.source(sources: "abc-news", pageSize: 10, page: 1)) { result in
            switch result {
                case .success(let response):
                    print("SUKSESSS \(response)")
                case .failure(let error):
                    print("ERRRR", error)
            }
        }
    }

}
