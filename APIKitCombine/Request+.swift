//
//  Request+.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation
import APIKit

extension APIKit.Request where Self.Response: Decodable {
    
    var publisher: APIPublisher<Self> {
        return APIPublisher(request: self)
    }
    
}
