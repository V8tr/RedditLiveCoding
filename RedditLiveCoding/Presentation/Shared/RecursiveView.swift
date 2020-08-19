//
//  RecursiveView.swift
//  Reddit2
//
//  Created by Vadim Bulavin on 8/19/20.
//

import SwiftUI

struct RecursiveView<Data, RowContent>:
    View where Data: RandomAccessCollection, Data.Element: Identifiable, RowContent: View {
    
    let data: Data
    let children: KeyPath<Data.Element, Data?>
    let rowContent: (Data.Element) -> RowContent
    
    init(data: Data, children: KeyPath<Data.Element, Data?>, rowContent: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.children = children
        self.rowContent = rowContent
    }
    
    var body: some View {
        ForEach(data) { child in
            if self.containsSub(child)  {
                CustomDisclosureGroup(content: {
                    RecursiveView(data: child[keyPath: children]!,
                                  children: children,
                                  rowContent: rowContent)
                        .padding(.leading, 8)
                }, label: {
                    rowContent(child)
                })
            } else {
                rowContent(child)
            }
        }
    }
    
    func containsSub(_ element: Data.Element) -> Bool {
        element[keyPath: children] != nil
    }
}

struct CustomDisclosureGroup<Label, Content>: View where Label: View, Content: View {
    @State var isExpanded: Bool = true
    var content: () -> Content
    var label: () -> Label
    
    var body: some View {
        label()
            .onTapGesture {
                isExpanded.toggle()
        }
        if isExpanded {
            content()
        }
    }
}
