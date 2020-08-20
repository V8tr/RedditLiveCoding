//
//  SubredditView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct SubredditView: View {
    var body: some View {
        NavigationView {
            SubredditPostsListContainer(subreddit: "swift")
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(leading: Text("r/swift"))
        }
    }
}
