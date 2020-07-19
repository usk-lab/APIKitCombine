//
//  GitHubDecoder.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation

/// GitHubのレスポンス用のJSONデコーダー
class GitHubDecoder: JSONDecoder {
    
    override init() {
        super.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
    
}
