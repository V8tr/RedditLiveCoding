//
//  SubredditPostsListContainer.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct SubredditPostsListContainer: View {
    @StateObject var viewModel: SubredditPostsViewModel
    
    init(subreddit: String) {
        _viewModel = .init(wrappedValue:  SubredditPostsViewModel(subreddit: subreddit))
    }
    
    var body: some View {
        Group {
            if viewModel.posts.isEmpty {
                spinner
            } else {
                list
            }
        }
        .onAppear(perform: viewModel.fetchNextPage)
    }
    
    var list: some View {
        SubredditPostsListView(
            posts: viewModel.posts,
            onScrolledAtEnd: viewModel.fetchNextPage
        )
    }
    
    var spinner: some View {
        Spinner(style: .medium)
    }
}
