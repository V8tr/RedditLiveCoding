//
//  CommentsRecursiveView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/20/20.
//

import SwiftUI

struct CommentsRecursiveView: View {
    let comments: [Comment]
    @State private var expansion = Set<String>()

    public var body: some View {
        ForEach(comments) { comment in
            if let replies = comment.repliesComments  {
                DisclosureGroup(isExpanded: isCommentExpanded(comment.id)) {
                    CommentsRecursiveView(comments: replies)
                        .padding(.leading, 8)
                } label: {
                    CommentRowView(comment: comment)
                }
            }
            else {
                CommentRowView(comment: comment)
            }
        }
    }

    private func isCommentExpanded(_ commentID: String) -> Binding<Bool> {
        .init(
            get: { expansion.contains(commentID) },
            set: { _ in
                if expansion.contains(commentID) {
                    expansion.remove(commentID)
                } else {
                    expansion.insert(commentID)
                }
            }
        )
    }
}
