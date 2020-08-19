//
//  PostMetadataView.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct MetadataView: View {
    static let formatter = RelativeDateTimeFormatter()

    let post: SubredditPost
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: "arrow.up")
                Text("\(post.score)")
            }
            .foregroundColor(Color.orange)
            
            Group {
                Image(systemName: "text.bubble")
                Text("\(post.numComments)")
            }
            .foregroundColor(Color.primary)
            
            Group {
                Image(systemName: "clock")
                Text("\(Self.formatter.localizedString(for: post.createdUtc, relativeTo: Date()))")
            }
            .foregroundColor(Color.primary)
        }
    }
}
