//
//  API.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/16/20.
//

import Foundation
import Combine

enum RedditAPI {
    static var session = URLSession.shared
    static var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    static let base = URL(string: "https://www.reddit.com/")!
    
    static func fetchPosts(
        subreddit: String,
        sort: String,
        after postID: String?
    ) -> AnyPublisher<[SubredditPost], Error> {

        var components = URLComponents(
            url: Self.base.appendingPathComponent("/r/\(subreddit)/\(sort).json"),
            resolvingAgainstBaseURL: false
        )

        if let postID = postID {
            components?.queryItems = [.init(name: "after", value: "t3_\(postID)")]
        }

        return session.dataTaskPublisher(for: components!.url!)
            .map(\.data)
            .decode(type: ListingResponse<SubredditPost>.self, decoder: decoder)
            .compactMap { $0.data?.children.map { $0.data } }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func fetchComments(subreddit: String, postID: String) -> AnyPublisher<[Comment], Error> {
        let url = Self.base.appendingPathComponent("r/\(subreddit)/comments/\(postID).json")
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ListingResponse<Comment>].self, decoder: decoder)
            .compactMap { $0.last?.data?.children.compactMap { $0.data } }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

