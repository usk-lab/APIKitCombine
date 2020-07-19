//
//  ContentView.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var model: GitHubSearchModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("text to search", text: $model.searchText)
                    .padding()
                Divider()
                List (model.items) { item in
                    Text(item.fullName)
                }
            }.onDisappear {
                // 破棄される際に通信をキャンセルする
                self.model.cancel()
            }
            .navigationBarTitle("検索", displayMode: .inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
