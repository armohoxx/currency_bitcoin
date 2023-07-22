//
//  StringExtension.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation
import UIKit

extension String {
    
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
    
    var htmlAttributedString: NSAttributedString {
        return try! NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: .none)
    }
    
    func dictionary() -> NSDictionary? {
        if let data = self.data(using: .utf8) {
            guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                return nil
            }
            return dictionary
        }
        return nil
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
}
