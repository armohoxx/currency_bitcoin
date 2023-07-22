//
//  BitcoinEntity.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation
import Mapper

class BitcoinEntity: NSObject, Mappable {
    
    var updated: String
    var updatedISO: String
    var updateduk: String
    var disclaimer: String?
    var chartName: String?
    var usd: CurrencyBTC?
    var gbp: CurrencyBTC?
    var eur: CurrencyBTC?
        
    required init(map: Mapper) throws {
        self.updated = map.optionalFrom("time.updated") ?? ""
        self.updatedISO = map.optionalFrom("time.updatedISO") ?? ""
        self.updateduk = map.optionalFrom("time.updateduk") ?? ""
        self.disclaimer = map.optionalFrom("disclaimer")
        self.chartName = map.optionalFrom("chartName")
        
        let usdData: NSDictionary? = map.optionalFrom("bpi.USD")
        if let usdData = usdData {
            if let data = CurrencyBTC.from(usdData) {
                self.usd = data
            }
        }
        
        let gbpData: NSDictionary? = map.optionalFrom("bpi.GBP")
        if let gbpData = gbpData {
            if let data = CurrencyBTC.from(gbpData) {
                self.gbp = data
            }
        }
        
        let eurData: NSDictionary? = map.optionalFrom("bpi.EUR")
        if let eurData = eurData {
            if let data = CurrencyBTC.from(eurData) {
                self.eur = data
            }
        }
    }
    
}

class CurrencyBTC: NSObject, Mappable, Codable {
    
    var code: String
    var symbol: String
    var rate: String
    var descriptionCurrency: String
    var rate_float: Double
    
    required init(map: Mapper) throws {
        self.code = try map.from("code")
        self.symbol = try map.from("symbol")
        self.rate = try map.from("rate")
        self.descriptionCurrency = try map.from("description")
        self.rate_float = try map.from("rate_float")
    }
    
}
