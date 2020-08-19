//
//  API.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/16/20.
//

import Foundation
import Combine

enum APIError: LocalizedError {
    case unknown
    case notFound
    case api(RedditError)
    case unrecognizedResponse(Error)
}

struct RedditError: Decodable {
    let message: String?
    let error: Int?
}

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
    ) -> AnyPublisher<[SubredditPost], APIError> {

        var components = URLComponents(
            url: Self.base.appendingPathComponent("/r/\(subreddit)/\(sort).json"),
            resolvingAgainstBaseURL: false
        )

        if let postID = postID {
            components?.queryItems = [.init(name: "after", value: "t3_\(postID)")]
        }

        return session.dataTaskPublisher(for: components!.url!)
            .validateResponse()
            .decode(type: ListingResponse<SubredditPost>.self, decoder: decoder)
            .compactMap { $0.data?.children.map { $0.data } }
            .mapError(APIError.unrecognizedResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func fetchComments(subreddit: String, postID: String) -> AnyPublisher<[Comment], APIError> {
        let url = Self.base.appendingPathComponent("r/\(subreddit)/comments/\(postID).json")
        
        return session.dataTaskPublisher(for: url)
            .validateResponse()
            .handleEvents(receiveOutput: { data in print(NSString(data: data, encoding: 4)) })
            .decode(type: [ListingResponse<Comment>].self, decoder: decoder)
            .print()
            .compactMap { $0.last?.data?.children.map { $0.data } }
            .mapError(APIError.unrecognizedResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension URLSession.DataTaskPublisher {
    func validateResponse() -> AnyPublisher<Data, APIError> {
        self.tryMap { data, response -> Data in
            guard let response = response as? HTTPURLResponse else { throw APIError.unknown }
            switch response.statusCode {
            case 200..<300:
                return data
            case 404:
                throw APIError.notFound
            default:
                do {
                    let underlyingError = try JSONDecoder().decode(RedditError.self, from: data)
                    throw APIError.api(underlyingError)
                } catch {
                    throw APIError.unrecognizedResponse(error)
                }
            }
        }
        .mapError { $0 as! APIError }
        .eraseToAnyPublisher()
    }
}

struct CommentListing: Decodable {
    let data: CommentListingData
    
    struct CommentListingData: Decodable {
        let children: [CommentData]
        
        struct CommentData: Decodable {
            let data: Comment
        }
    }
}
