//
//  CommentRowView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/20/20.
//

import SwiftUI

struct CommentRowView: View {
    let comment: Comment

    @ViewBuilder
    var body: some View {
        HStack {
            if let depth = comment.depth, depth > 0 {
                border(depth: depth)
            }
            content
        }
        .fixedSize(horizontal: false, vertical: true)
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

    func border(depth: Int) -> some View {
        RoundedRectangle(cornerRadius: 1.5)
            .foregroundColor(Color(hue: 1.0 / Double(depth), saturation: 1.0, brightness: 1.0))
            .frame(width: 3)
    }
}
