//
//  SubredditPostsViewModel.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/17/20.
//

import Foundation
import Combine
import SwiftUI

class SubredditPostsViewModel: ObservableObject {
    
    let subredditName: String
    
    @Published var subreddit: Subreddit?
    @Published var posts: [SubredditPost] = []
    private var canLoadNextPage = true

    @AppStorage("subreddit-default-sort") var sortOrder = Sort.hot {
        didSet {
            posts = []
            canLoadNextPage = true
            fetchNextPage()
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()

    init(subredditName: String) {
        self.subredditName = subredditName
    }
    
    func fetchNextPage() {
        guard canLoadNextPage else { return }

        RedditAPI.fetchPosts(subreddit: subredditName, sort: sortOrder.rawValue, after: nil)
            .print()
            .replaceError(with: [])
            .sink { [weak self] (posts: [SubredditPost]) in
                self?.posts += posts
                self?.canLoadNextPage = !posts.isEmpty
            }
            .store(in: &subscriptions)
    }
    
    enum Sort: String, CaseIterable {
        case top, best, new, rising, hot
    }
    
    enum Status {
        case idle, loading, finishedLoading
    }
}
