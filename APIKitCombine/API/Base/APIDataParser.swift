//
//  APIDataParser.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation
import APIKit

/// Decodableに準拠するデータをデコードする
struct APIDataParser<T: Decodable>: APIKit.DataParser {
    
    let decoder: JSONDecoder //デコーダー
    
    var contentType: String? {
        return "application/json" //レスポンスはJSON形式
    }

    func parse(data: Data) throws -> Any {
        // デコードする
        return try decoder.decode(T.self, from: data)
    }
}
