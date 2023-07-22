//
//  DBHistoryCurrencyBitcoinHelper.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 22/7/2566 BE.
//

import Foundation
import UIKit
import SQLite
import CoreData

class DBHistoryCurrencyBitcoinHelper {
    static let shared = DBHistoryCurrencyBitcoinHelper()
    static var historyCurrencyBitcoin = Table("historyCurrencyBitcoin")
    static let time_updated = Expression<Int64?>("time_updated")
    static let currency_bitcoin_data = Expression<String?>("currency_bitcoin_data")
    
    var historyCurrencyBitcoin = [HistoryBitcoin]()
   
    static func createHistoryCurrencyBitcoin() {
        guard let database = DBHistoryCurrencyBitcoin.sharedInstance.database else {
            print("Database connection error")
            return
        }
    
        do {
            try database.run(historyCurrencyBitcoin.create(ifNotExists: true) { historyCurrencyBitcoin in
                historyCurrencyBitcoin.column(time_updated)
                historyCurrencyBitcoin.column(currency_bitcoin_data)
            })
        } catch {
            print("historyCurrencyBitcoin already exists: \(error)")
        }
    }
    
    static func insertHealthReport(timeUpdated: Int64,
                                 currencyBitcoinData: String) {
        guard let database = DBHistoryCurrencyBitcoin.sharedInstance.database else {
            print("Database connection error")
            return
        }

        do {
            try database.transaction {
                let filteredTable = historyCurrencyBitcoin.filter(time_updated == timeUpdated)
                if try database.run(filteredTable.update(time_updated <- timeUpdated,
                                                         currency_bitcoin_data <- currencyBitcoinData)) != 0 {

                    print("update historyCurrencyBitcoin")
                } else {
                    try database.run(historyCurrencyBitcoin.insert(time_updated <- timeUpdated,
                                                                currency_bitcoin_data <- currencyBitcoinData))

                    print("insert historyCurrencyBitcoin")
                }
            }
        } catch let error {
            print("Insert historyCurrencyBitcoin failed: \(error)")
        }
    }
    
    func selectCurrencyBitcoin() -> [HistoryBitcoin]? {
        var timeUpdatedData: Int64?
        var stringData: String?
        
        guard let database = DBHistoryCurrencyBitcoin.sharedInstance.database else {
            print("Database connection error")
            return nil
        }
        
        do {
            for data in try database.prepare("select * from historyCurrencyBitcoin ORDER BY time_updated DESC LIMIT 50") {
                
                if let dataTimeUpdated: Int64 = Optional(data[0]) as? Int64 {
                    timeUpdatedData = dataTimeUpdated
                } else {
                    timeUpdatedData = nil
                }
                
                if let dataString: String = Optional(data[1]) as? String {
                    stringData = dataString
                } else {
                    stringData = nil
                }
                
                let history = HistoryBitcoin(time_updated: timeUpdatedData ?? 0,
                                             currency_bitcoin_data: stringData ?? "")

                self.historyCurrencyBitcoin.append(history)
            }
        } catch {
            print("error selectCurrencyBitcoin")
            return nil
        }
        return self.historyCurrencyBitcoin
    }

    func deleteAllCurrencyBitcoin() {
        guard let database = DBHistoryCurrencyBitcoin.sharedInstance.database else {
            print("Database connection error")
            return
        }

        do {
            for data in try database.prepare("delete from DBHistoryCurrencyBitcoin") {
                print("deleteAllDBHistoryCurrencyBitcoin = \(data)")
            }
        } catch {
            print("error delete DBHistoryCurrencyBitcoin")
        }
    }
    
}
