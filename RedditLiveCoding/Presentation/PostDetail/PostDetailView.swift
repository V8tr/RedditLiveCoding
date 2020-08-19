//
//  PostDetailView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostDetailView: View {
    let post: SubredditPost
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 20) {
                title
                content
                MetadataView(post: post)
                CommentsView(postID: post.id, subreddit: post.subreddit)
            }
        }
    }
    
    var title: some View {
        VStack(alignment: .leading) {
            Text(post.author)
                .font(.caption)
                .opacity(0.75)
            Text(post.title)
                .font(.title)
                .bold()
        }
    }
    
    @ViewBuilder
    var content: some View {
        if let text = post.selftext ?? post.description {
            Text(text).font(.body)
        }
        if let url = post.url, let realURL = URL(string: url) {
            if realURL.pathExtension == "jpg" || realURL.pathExtension == "png" {
                HStack {
                    Spacer()
                    WebImage(url: realURL)
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fit)
                        .background(Color.gray)
                        .frame(maxHeight: 400)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

