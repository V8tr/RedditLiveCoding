//
//  SubredditPost.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/17/20.
//

import Foundation

struct SubredditPost: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let title: String
    let numComments: Int
    let subreddit: String
    let thumbnail: String
    let created: Date
    let createdUtc: Date
    var thumbnailURL: URL? { URL(string: thumbnail) }
    let author: String
    let selftext: String?
    let description: String?
    var ups: Int
    let downs: Int
    let score: Int
    let url: String?
    let permalink: String?
    let linkFlairText: String?
    let linkFlairBackgroundColor: String?
    let linkFlairTextColor: String?
    var visited: Bool
    var saved: Bool
    var redditURL: URL? {
        if let permalink = permalink, let url = URL(string: "https://reddit.com\(permalink)") {
            return url
        }
        return nil
    }
    var likes: Bool?
}

extension SubredditPost {
    static let post1 = SubredditPost(
        id: "1",
        name: "Post #1",
        title: "This is post #1 title",
        numComments: 10,
        subreddit: "Subreddit",
        thumbnail: "",
        created: Date() - 60 * 11,
        createdUtc: Date(),
        author: "V8tr",
        selftext: "Body body body",
        description: "Description",
        ups: 10,
        downs: 3,
        score: 7,
        url: "https://www.google.com",
        permalink: nil,
        linkFlairText: "Flair",
        linkFlairBackgroundColor: nil,
        linkFlairTextColor: nil,
        visited: true,
        saved: true,
        likes: true
    )
}
