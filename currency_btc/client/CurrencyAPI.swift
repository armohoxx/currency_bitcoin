//
//  CurrencyAPI.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 19/7/2566 BE.
//

import Foundation
import Moya
import SwiftyJSON

enum CurrencyAPI {
    case FetchCurrencyBitcoin
}

extension CurrencyAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: url)!
    }
    
    var url: String {
        switch self {
            
        case .FetchCurrencyBitcoin:
            return Constants.DefaultAPIURL
        }
    }
    
    var path: String{
        switch self {
            
        case .FetchCurrencyBitcoin:
           return "/v1/bpi/currentprice.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .FetchCurrencyBitcoin:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            
        case .FetchCurrencyBitcoin:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
        case .FetchCurrencyBitcoin:
            return [
                "Content-Type": "application/json",
            ]
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.httpBody
    }
    
}
