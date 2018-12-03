//
//  Article.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 03/12/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import Foundation

class Article {
    let title: String
    let description: String
    let imageUrl: String
    
    init(title: String, description: String, imageUrl: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
}
