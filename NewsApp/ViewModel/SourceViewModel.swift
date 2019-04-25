//
//  SourceViewModel.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 25/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import Foundation

struct SourceViewModel {
    let title: String
    let description: String
    let id: String
    
    init(id: String, title: String, description: String) {
        self.id = id
        self.title = "Source: \(title)"
        self.description = description
    }
}
