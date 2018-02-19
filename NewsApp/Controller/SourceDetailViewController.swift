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
    
    var _name: String?
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        _name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = self._name
    }

}
