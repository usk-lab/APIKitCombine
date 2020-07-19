//
//  APIDataParser.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation
import APIKit

struct APIDataParser<T: Decodable>: APIKit.DataParser {
    
    let decoder: JSONDecoder
    
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        // デコードする
        return try decoder.decode(T.self, from: data)
    }
}
