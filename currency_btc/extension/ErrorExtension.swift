//
//  ErrorExtension.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation

extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
