//
//  GitHubRepository.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation
import APIKit

class GitHubRepository {
    
    //GitHubレスポンス用のデコーダー
    static let decoder: GitHubDecoder = .init()
    
    //リポジトリを検索
    struct SearchRepositories: GitHubRequestProtocol {
        //https://developer.github.com/v3/search

        //検索クエリ
        let query: String
        
        let method: HTTPMethod = .get
        let path: String = "/search/repositories"
        var decoder: JSONDecoder {
            return GitHubRepository.decoder
        }
        
        var params: [String: Any] {
            return [
                "q": query
            ]
        }
        
        typealias Response = SearchResponse

    }
    
    private init() { }
}
