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

class GitHubSearchModel: ObservableObject {
        
    @Published var items: [SearchItem] = [] //検索結果
    
    var searchText: String = "" {
        didSet { didChange.send(()) }
    }
    
    // APIキャンセル用インスタンス
    var requestCancellable: Cancellable?
    
    let didChange = PassthroughSubject<Void, Never>()
    private var cancellable: AnyCancellable?
    
    init() {
        
        cancellable = didChange
            .debounce(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.search()
        }

    }
    
    func cancel() {
        self.requestCancellable?.cancel()
        self.requestCancellable = nil
    }
    
}

private extension GitHubSearchModel {
    
    func search() {
        debugPrint("search")
        
        let request = GitHubRepository.SearchRepositories(query: searchText)
        self.requestCancellable = request.publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                 case .finished:
                    debugPrint("request finished")
                    break
                 case .failure(let error):
                    debugPrint("request failed : \(error)")
                    break
                 }
            }, receiveValue: { [weak self] response in
                self?.items = response.items
            })
        
    }
        
}
