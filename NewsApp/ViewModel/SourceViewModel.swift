//
//  SourceViewModel.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 25/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct SourceViewModel {
//    let title: String
//    let description: String
//    let id: String
    
//    init(id: String, title: String, description: String) {
//        self.id = id
//        self.title = "Source: \(title)"
//        self.description = description
//    }
    
    public struct Input {
        public let viewDidLoad: Driver<Void>
    }
    
    public struct Output {
        public let sources: Driver<[Source]>
    }
    
    public func transform(input: Input) -> Output {
        
        let sources = input.viewDidLoad.map { _ -> [Source] in
            return [Source(sourceId: "1", title: "halo", description: "Hehehe")]
        }
        
        return Output(
            sources: sources
        )
    }
    
}
