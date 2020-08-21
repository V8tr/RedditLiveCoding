//
//  CommentsContainerView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct CommentsContainerView: View {
    @StateObject var viewModel: PostCommentsViewModel
    
    init(postID: String, subreddit: String) {
        _viewModel = .init(wrappedValue: PostCommentsViewModel(postID: postID, subreddit: subreddit))
    }
    
    var body: some View {
        Group {
            if let comments = viewModel.comments {
                CommentsRecursiveView(comments: comments)
            } else {
                Spinner(style: .medium)
            }
        }
        .onAppear(perform: viewModel.fetchComments)
    }
    
    var spinner: some View {
        Spinner(style: .medium)
    }
}
