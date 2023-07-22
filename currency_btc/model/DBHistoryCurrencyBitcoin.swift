//
//  DBHistoryCurrencyBitcoin.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 22/7/2566 BE.
//

import Foundation
import SQLite
import UIKit

class DBHistoryCurrencyBitcoin {
    static let sharedInstance: DBHistoryCurrencyBitcoin = DBHistoryCurrencyBitcoin()
    var database: Connection? = nil
    let filename: String = "DBHistoryCurrencyBitcoin.sqlite"
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .applicationSupportDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil, create: true)
            let directoryURL = documentDirectory.appendingPathComponent("currency-bitcoin").appendingPathComponent("Database")
            
            do {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Someting wrong in folder DB")
            }
            
            let fileUrl = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("currency-bitcoin").appendingPathComponent("Database").appendingPathComponent(filename)
            
            database = try Connection(fileUrl.path)
        } catch {
            print("create connection to database error : \(error)")
            //database = nil
        }
    }
    
    func createTable() {
        DBHistoryCurrencyBitcoinHelper.createHistoryCurrencyBitcoin()
    }
}
