//
//  SourceDetailViewController.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 2/19/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit

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
        
    }

}
