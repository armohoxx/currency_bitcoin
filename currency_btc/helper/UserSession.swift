//
//  UserSession.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation
import UIKit
import SwiftyJSON

class UserSession {
    
    static let shared = UserSession()
    static let currencyBTC = "currencyBTC"
    
    func setCurrencyBTC(string: String) {
        UserDefaults.standard.set(string, forKey: UserSession.currencyBTC)
        UserDefaults.standard.synchronize()
    }
    
    func getCurrencyBTC() -> BitcoinEntity? {
        if let currencyBTCString = UserDefaults.standard.string(forKey: UserSession.currencyBTC) {
            if let jsonResult = currencyBTCString.dictionary() {
                if let currencyBitcoinData = BitcoinEntity.from(jsonResult) {
                    if let healthCurrencyBitcoin = DBHistoryCurrencyBitcoinHelper.shared.selectCurrencyBitcoin() {
                        for data in healthCurrencyBitcoin {
                            let formatter = DateFormatter()
                            formatter.locale = Locale(identifier: "en_US_POSIX")
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            
                            let timeUpdatedData = Int64(formatter.date(from: currencyBitcoinData.updatedISO)?.timeIntervalSince1970 ?? 0)
                            
                            if data.time_updated != timeUpdatedData {
                                DBHistoryCurrencyBitcoinHelper.insertHealthReport(timeUpdated: timeUpdatedData, currencyBitcoinData: currencyBTCString)
                            }
                        }
                    } else {
                        let formatter = DateFormatter()
                        formatter.locale = Locale(identifier: "en_US_POSIX")
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        
                        let timeUpdatedData = Int64(formatter.date(from: currencyBitcoinData.updatedISO)?.timeIntervalSince1970 ?? 0)
                        
                        DBHistoryCurrencyBitcoinHelper.insertHealthReport(timeUpdated: timeUpdatedData, currencyBitcoinData: currencyBTCString)
                    }
                    return currencyBitcoinData
                }
            }
        }
        return nil
    }
    
}
