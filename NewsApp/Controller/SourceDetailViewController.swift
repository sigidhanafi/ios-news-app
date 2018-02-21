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
    
    var _title: String?
    var _sourceId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self._title

        let provider = MoyaProvider<NewsApiService>()
        provider.request(.source(sources: self._sourceId, pageSize: 10, page: 1)) { result in
            switch result {
                case .success(let response):
                    print("SUKSESSS \(response)")
                case .failure(let error):
                    print("ERRRR", error)
            }
        }
    }

}
