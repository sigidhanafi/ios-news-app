//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 25/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    let title: String
    let description: String
    let imageUrl: String
    
    init(title: String, description: String, imageUrl: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
}
