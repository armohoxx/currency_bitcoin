//
//  DictionaryExtension.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import Foundation

extension Dictionary {
    
    var dictionaryToString: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) as NSData else {
            return nil
        }
        return String(data: theJSONData as Data, encoding: String.Encoding.utf8)
    }
    
    func containsKey(_ key: Key) -> Value? {
        if let index = index(forKey: key){
            return self.values[index]
        }
        return nil
    }
    
}

extension NSDictionary {
    
    var dictionaryToString: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) as NSData else {
            return nil
        }
        return String(data: theJSONData as Data, encoding: String.Encoding.utf8)
    }
    
}
