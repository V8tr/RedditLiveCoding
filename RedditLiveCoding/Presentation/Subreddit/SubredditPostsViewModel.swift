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
    let subreddit: String
    
    @Published var posts: [SubredditPost] = []
    private var canLoadNextPage = true
    
    private var subscriptions = Set<AnyCancellable>()

    init(subreddit: String) {
        self.subreddit = subreddit
    }
    
    func fetchNextPage() {
        guard canLoadNextPage else { return }

        RedditAPI.fetchPosts(subreddit: subreddit, sort: "hot", after: posts.last?.id)
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
