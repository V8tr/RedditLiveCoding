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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                title
                content
                MetadataView(post: post)
                CommentsContainerView(postID: post.id, subreddit: post.subreddit)
            }
            .frame(idealWidth: .infinity, maxWidth: .infinity)
            .padding()
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
        if let url = post.url.flatMap({ URL(string: $0) }) {
            if url.pathExtension == "jpg" || url.pathExtension == "png" {
                HStack {
                    Spacer()
                    WebImage(url: url)
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fit)
                        .background(Color.gray)
                        .frame(maxHeight: 400)
                        .padding()
                    Spacer()
                }
            } else if post.selftext == nil || post.selftext?.isEmpty == true {
                LinkPresentationView(url: url)
            }
        }
    }
}

