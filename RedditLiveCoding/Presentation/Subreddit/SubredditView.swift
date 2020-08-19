//
//  SubredditView.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct SubredditView: View {
    @State var subreddit = "swift"
    @State var isEditingSubreddit = false
    
    var body: some View {
        NavigationView {
            SubredditPostsListContainer(subredditName: subreddit)
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    Button(action: {
                        self.isEditingSubreddit = true
                    }) {
                        Text("r/\(self.subreddit)")
                    }
                })
                .popover(isPresented: $isEditingSubreddit, attachmentAnchor: .point(UnitPoint(x: 20, y: 20))) {
                    HStack(spacing: 0) {
                        Text("r/")
                        TextField("Subreddit", text: self.$subreddit) {
                            self.isEditingSubreddit = false
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(width: 200)
                    .padding()
                    .cornerRadius(10)
                }
        }
    }
}
