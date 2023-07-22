//
//  MessageResponse.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation
import Mapper

class MessageResponse: NSObject, Mappable {
    
    var status: String
    var dataArray: [NSDictionary]?
    var data: NSDictionary?
    
    required init(map: Mapper) throws {
        self.status = map.optionalFrom("status") ?? ""
        self.dataArray = map.optionalFrom("data")
        self.data = map.optionalFrom("data")
    }
    
}
