//
//  CommentsView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct CommentsView: View {
    @StateObject var viewModel: PostCommentsViewModel
    
    init(postID: String, subreddit: String) {
        _viewModel = .init(wrappedValue: PostCommentsViewModel(postID: postID, subreddit: subreddit))
    }
    
    var body: some View {
        Group {
            if viewModel.comments.isEmpty {
                Spinner(style: .medium)
            } else {
                CommentsRecursiveView(comments: viewModel.comments)
            }
        }
        .onAppear(perform: viewModel.fetchComments)
    }
    
    var spinner: some View {
        Spinner(style: .medium)
    }
}
