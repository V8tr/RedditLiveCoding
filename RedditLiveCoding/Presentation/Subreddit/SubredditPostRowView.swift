//
//  SubredditPostRowView.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct SubredditPostRowView: View {
    let post: SubredditPost
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.headline)
                    .lineLimit(1)
                
                post.url.map(Text.init)
                    .font(.caption)
                    .opacity(0.75)
                    .lineLimit(1)
                
                MetadataView(post: post)
                    .font(.caption)
                    .opacity(0.75)
            }
            if post.thumbnail != "self" {
                Spacer()
                WebImage(url: post.thumbnailURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipped()
                    .cornerRadius(5.0)
            }
        }
    }
    
    var preview: some View {
        let url = post.url.map(Text.init)
        let selftext = post.selftext.map(Text.init)
        return selftext ?? url ?? Text(" ")
    }
}
