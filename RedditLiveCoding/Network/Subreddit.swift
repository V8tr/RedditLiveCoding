//
//  Subreddit.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/17/20.
//

import Foundation

struct Subreddit: Codable, Identifiable, Hashable {
    let id: String
    let displayName: String
    let title: String
    let Description: String?
    let primaryColor: String?
    let keyColor: String?
    let bannerBackgroundColor: String?
    let iconImg: String?
    let bannerImg: String?
    let subscribers: Int?
    let accountsActive: Int?
}
