//
//  SearchResponse.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let items: [SearchItem]
}

struct SearchItem: Decodable, Identifiable {
    let id: Int
    let fullName: String
}
