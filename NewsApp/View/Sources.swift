//
//  Sources.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 03/12/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import Foundation

class Sources {
    let sourceId: String
    let title: String
    let description: String
    
    init(sourceId: String, title: String, description: String) {
        self.sourceId = sourceId
        self.title = title
        self.description = description
    }
}
