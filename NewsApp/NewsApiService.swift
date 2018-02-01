//
//  NewsApiService.swift
//  NewsApp
//
//  Created by Sigit Hanafi on 2/2/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import Foundation
import Moya

enum NewsApiService {
    case source
}

extension NewsApiService: TargetType {
    var baseURL: URL { return URL(string: "https://newsapi.org/v2/sources")! }
    var path: String {
        switch self {
        case .source:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .source:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    var task: Task {
        switch self {
        case .source:
            return .requestPlain
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return["X-Api-Key": "871c4309f5864dc28ac26a72e3ada496"]
    }
}
