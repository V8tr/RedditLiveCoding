//
//  Comment.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/17/20.
//

import Foundation

struct Comment: Decodable, Identifiable {
    let id: String
    let name: String
    let body: String?
    let author: String?
    let lindId: String?
    let created: Date?
    let createdUtc: Date?
    let replies: Replies?
    let score: Int?
    let depth: Int?
    
    var repliesComments: [Comment]? {
        if let replies = replies {
            switch replies {
            case let .some(replies):
                return replies.data?.children.map { $0.data }
            default:
                return nil
            }
        }
        return nil
    }
}

enum Replies: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = .some(try container.decode(ListingResponse<Comment>.self))
        } catch {
            self = .none(try container.decode(String.self))
        }
    }
    
    case some(ListingResponse<Comment>)
    case none(String)
}
