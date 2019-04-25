//
//  SourceTableViewCell.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 1/11/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceTitle: UILabel!
    @IBOutlet weak var sourceDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sourceTitle.numberOfLines = 1
        sourceTitle.lineBreakMode = .byTruncatingTail
        
        sourceDesc.numberOfLines = 2
        sourceDesc.lineBreakMode = .byTruncatingTail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
