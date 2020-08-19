//
//  Listing.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/17/20.
//

import Foundation

struct ListingResponse<T: Decodable>: Decodable {
    let kind: String?
    let data: ListingData<T>?
    let errorMessage: String?
    
    init(error: String) {
        self.errorMessage = error
        self.kind = nil
        self.data = nil
    }
}

struct ListingData<T: Decodable>: Decodable {
    let modhash: String?
    let dist: Int?
    let after: String?
    let before: String?
    let children: [ListingHolder<T>]
}

struct ListingHolder<T: Decodable>: Decodable {
    let kind: String
    let data: T
    
    enum CodingKeys : CodingKey {
        case kind, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        kind = try container.decode(String.self, forKey: .kind)
        if T.self == GenericListingContent.self {
            data = try GenericListingContent(from: decoder) as! T
        } else {
            data = try container.decode(T.self, forKey: .data)
        }
    }
}

enum GenericListingContent: Decodable, Identifiable {
    var id: String {
        switch self {
        case let .post(post):
            return post.id
        case let .comment(comment):
            return comment.id
        default:
            return UUID().uuidString
        }
    }
    
    var post: SubredditPost? {
        if case .post(let post) = self {
            return post
        }
        return nil
    }
    
    var comment: Comment? {
        if case .comment(let comment) = self {
            return comment
        }
        return nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListingHolder<GenericListingContent>.CodingKeys.self)
        let kind = try container.decode(String.self, forKey: .kind)
        switch kind {
        case "t1":
            self = .comment(try container.decode(Comment.self, forKey: .data))
        case "t3":
            self = .post(try container.decode(SubredditPost.self, forKey: .data))
        default:
            self = .notSupported
        }
    }
    
    case post(SubredditPost)
    case comment(Comment)
    case notSupported
}

