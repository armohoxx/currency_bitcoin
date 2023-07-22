//
//  CurrencyAPIHelper.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation
import Moya

var instanceCurrencyAPIHelper: CurrencyAPIHelper? = nil

class CurrencyAPIHelper {
    
    static func sharedInstance() -> CurrencyAPIHelper {
        
        if instanceCurrencyAPIHelper == nil {
            instanceCurrencyAPIHelper = CurrencyAPIHelper()
        }
        
        return instanceCurrencyAPIHelper!
    }
    
    func fetchCurrencyBitcoin(completion: @escaping (_ statusFetchCurrencyBitcoin: String) -> Void) {
        
        NetworkAdapter.request(target: .FetchCurrencyBitcoin, success: { (response) in
            do {
                let json = try response.mapJSON() as! NSDictionary
                let jsonResultString = json.dictionaryToString ?? ""
                
                //print("jsonResultString fetchCurrencyBitcoin = ", jsonResultString)
                
                if let codeData = ResponseCode.from(json), codeData.code == 5 {
                   UserSession.shared.setCurrencyBTC(string: jsonResultString)
                   completion("\(codeData.message ?? "")")
                } else {
                    UserSession.shared.setCurrencyBTC(string: jsonResultString)
                    completion("ok")
                }
            } catch let error {
                let errorStatusCode = (error as? MoyaError)?.response?.statusCode
                if errorStatusCode == 401 {
                    completion("401")
                } else {
                    let code = error.errorCode
                    let message = error.localizedDescription
                    let localizedCancelled = NSLocalizedString("\(ErrorAPI.ErrorCancelled.rawValue)", comment: "")
                    if code == 6 || message.contains("\(localizedCancelled)") {
                        completion("\(ErrorAPI.ErrorCancelled.rawValue)")
                    }else {
                        completion("\(ErrorAPI.ErrorExecute.rawValue)")
                    }
                }
            }
        }) { (error) in
            let errorStatusCode = (error as? MoyaError)?.response?.statusCode
            if errorStatusCode == 401 {
                completion("401")
            } else {
                let code = error.errorCode
                let message = error.localizedDescription
                let localizedCancelled = NSLocalizedString("\(ErrorAPI.ErrorCancelled.rawValue)", comment: "")
                if code == 6 || message.contains("\(localizedCancelled)") {
                    completion("\(ErrorAPI.ErrorCancelled.rawValue)")
                }else {
                    completion("\(ErrorAPI.ErrorExecute.rawValue)")
                }
            }
        }
    }
    
}
