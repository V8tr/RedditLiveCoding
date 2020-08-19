//
//  CommentsView.swift
//  Reddit2
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
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.comments) { comment in
                CommentRowView(comment: comment)
                Divider()
            }
        }
        .onAppear(perform: viewModel.fetchComments)
    }
}

struct CommentRowView: View {
    let comment: Comment
    
    var depth: Int {
        comment.depth ?? 0
    }
    
    @ViewBuilder
    var body: some View {
        HStack {
            if depth > 0 {
                border
            }
            
            content
                .padding(.leading, CGFloat(depth * 10))
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            HStack {
                comment.author.map(Text.init)
                
                Image(systemName: "arrow.up")
                comment.score.map { Text("\($0)") }
            }
            .font(.caption)
            .foregroundColor(Color.gray)
            
            if let body = comment.body {
                Text(body)
                    .font(.body)
                    .foregroundColor(Color.primary)
            }
        }
    }
    
    var border: some View {
        RoundedRectangle(cornerRadius: 1.5)
            .foregroundColor(Color(hue: 1.0 / Double(depth), saturation: 1.0, brightness: 1.0))
            .frame(width: 3)
    }
}
