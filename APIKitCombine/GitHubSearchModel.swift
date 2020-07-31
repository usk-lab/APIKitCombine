//
//  GitHubSearchModel.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation
import Combine
import APIKit

/// 検索モデル
class GitHubSearchModel: ObservableObject {
        
    @Published var items: [SearchItem] = [] //検索結果
    
    var searchText: String = "" {
        didSet { didChange.send(()) }
    }
    
    // APIキャンセル用インスタンス
    var requestCancellable: Cancellable?
    
    // テキスト入力に対して遅延を行う
    let didChange = PassthroughSubject<Void, Never>()
    private var cancellable: AnyCancellable?
    
    init() {
        
        cancellable = didChange
            .debounce(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                //１秒入力していなかったら、検索処理を行う
                self?.search()
        }

    }
    
    func cancel() {
        self.requestCancellable?.cancel()
        self.requestCancellable = nil
    }
    
}

private extension GitHubSearchModel {
    
    /// 検索を行う
    func search() {
        debugPrint("search")
        
        // 1)APIリクエストを作成
        let request = GitHubRepository.SearchRepositories(query: searchText)
        
        // 2)CombineのPublisherを作成し、通信処理を行う
        self.requestCancellable = request.publisher //Publisherに変換（この時点で通信処理を行なっている）
            .receive(on: DispatchQueue.main) //メインスレッドで受け取る
            .sink(receiveCompletion: { result in
                switch result {
                 case .finished: //完了した
                    debugPrint("request finished")
                    break
                 case .failure(let error): //失敗した
                    debugPrint("request failed : \(error)")
                    break
                 }
            }, receiveValue: { [weak self] response in
                // 3)結果をitemsに保存
                self?.items = response.items
            })
        
        // 4)itemsの更新はCombineを通して通知される
        
    }
        
}
