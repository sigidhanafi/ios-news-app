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
    case sources
    case source(sources: String?, pageSize: Int?, page: Int?)
}

extension NewsApiService: TargetType {
    var baseURL: URL {
        switch self {
        case .sources:
            return URL(string: "https://newsapi.org/v2/sources")!
        case .source:
            return URL(string: "https://newsapi.org/v2/everything")!
        }
    }
    var path: String {
        switch self {
        case .sources:
            return ""
        case .source:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .sources:
            return .get
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
        case .sources:
            return .requestPlain
        case .source(let source, let pageSize, let page):
            var params: [String: Any] = [:]
            params["sources"] = source
            params["pageSize"] = pageSize
            params["page"] = page
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return["X-Api-Key": "871c4309f5864dc28ac26a72e3ada496"]
    }
}
