//
//  ResponseStatus.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 19/7/2566 BE.
//

import Foundation
import Mapper

class ResponseStatus: NSObject, Mappable {
    
    var message: String?
    var log: String?
    var isOK: Bool
    
    required init(map: Mapper) throws {
        self.isOK = false
        if let status = map.optionalFrom("status") as String?,
            status.lowercased() == "ok" {
            self.isOK = true
        }
        self.message = map.optionalFrom("message") ?? map.optionalFrom("error")
        self.log = map.optionalFrom("log")
    }
    
}
