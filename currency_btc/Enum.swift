//
//  Enum.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation

enum ErrorAPI: String {
    case ErrorCancelled = "cancelled"
    case ErrorExecute = "execute_database_fail"
}

enum ConstraintCurrencyPage: Int {
    case DefaultSizeCellCurrency
    case DefaultConstraintLeftRight
    
    var cgFloatValue: CGFloat {
        switch self {
        case .DefaultSizeCellCurrency: return 290
        case .DefaultConstraintLeftRight: return 30
        }
    }
}
