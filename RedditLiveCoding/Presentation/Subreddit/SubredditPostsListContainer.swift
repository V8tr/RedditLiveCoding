//
//  SubredditPostsListContainer.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct SubredditPostsListContainer: View {
    @StateObject var viewModel: SubredditPostsViewModel
    
    init(subredditName: String) {
        _viewModel = .init(wrappedValue:  SubredditPostsViewModel(subredditName: subredditName))
    }
    
    var body: some View {
        SubredditPostsListView(
            posts: viewModel.posts,
            onScrolledAtEnd: viewModel.fetchNextPage
        )
        .onAppear(perform: viewModel.fetchNextPage)
    }
}
