//
//  LinkPresentationView.swift
//  RedditLiveCoding
//
//  Created by Vadim Bulavin on 8/20/20.
//

import SwiftUI
import LinkPresentation

struct LinkPresentationView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> UIView {
        let view = LPLinkView(url: url)
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                }
            }
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
