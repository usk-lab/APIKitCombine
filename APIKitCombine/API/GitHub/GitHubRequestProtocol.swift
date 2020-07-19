//
//  GitHubRequestProtocol.swift
//  APIKitCombine
//
//  Created by Yusuke Hasegawa on 2020/07/19.
//  Copyright © 2020 USK. All rights reserved.
//

import Foundation
import APIKit

protocol GitHubRequestProtocol: Request {
    var params: [String: Any] { get } //パラメータ指定
    var decoder: JSONDecoder { get }  //Responseデコード用
}

extension GitHubRequestProtocol {
    
    //APIエンドポイント
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    //APIパラメーター
    var parameters: Any? {
        return params
    }
    
    #if DEBUG
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        debugPrint(urlRequest.url?.absoluteString ?? "")        
        return urlRequest
    }
    
    #endif
    
}

extension GitHubRequestProtocol where Response: Decodable {
    
    var dataParser: DataParser {
        return APIDataParser<Response>(decoder: decoder)
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        // Responseと型が一致していなければエラーを投げる
        guard let response = object as? Response else {
            throw ResponseError.unexpectedObject(object)
        }
        return response
    }
    
}
