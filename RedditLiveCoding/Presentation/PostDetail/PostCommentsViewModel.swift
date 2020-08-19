//
//  PostCommentsViewModel.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/19/20.
//

import Combine

class PostCommentsViewModel: ObservableObject {
    
    init(postID: String, subreddit: String) {
        self.postID = postID
        self.subreddit = subreddit
    }
    
    @Published var comments: [Comment] = []
    let postID: String
    let subreddit: String
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchComments() {
        RedditAPI.fetchComments(subreddit: subreddit, postID: postID)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] comments in
                    self?.comments = comments
                  })
            .store(in: &subscriptions)
    }
}
