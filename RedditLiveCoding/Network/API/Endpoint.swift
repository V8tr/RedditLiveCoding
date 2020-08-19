//
//  Endpoint.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/17/20.
//

import Foundation

enum Endpoint {
    case subreddit(name: String, sort: String)
    case postDetail
    case comments(subreddit: String, postID: String)
}

extension Endpoint {
    static let base = URL(string: "https://www.reddit.com/")!

    var asURLRequest: URLRequest {
        switch self {
        case let .subreddit(name: name, sort: sort):
            return URLRequest(url: Self.base.appendingPathComponent("/r/\(name)/\(sort).json"))
        case .postDetail:
            fatalError()
        case let .comments(subreddit: subreddit, postID: postID):
            return URLRequest(url: Self.base.appendingPathComponent("r/\(subreddit)/comments/\(postID).json"))
        }
    }
}
