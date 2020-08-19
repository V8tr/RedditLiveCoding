//
//  SubredditPostsListView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/18/20.
//

import SwiftUI

struct SubredditPostsListView: View {
    let posts: [SubredditPost]
    let onScrolledAtEnd: () -> Void

    var body: some View {
        List(posts) { post in
            NavigationLink(destination: PostDetailView(post: post)) {
                SubredditPostRowView(post: post)
                    .onAppear {
                        if post == posts.last {
                            onScrolledAtEnd()
                        }
                    }
            }
        }
    }
}
