//
//  CurrencyCell.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 20/7/2566 BE.
//

import UIKit

class CurrencyCell: UICollectionViewCell {

    @IBOutlet weak var contentCurrencyView: UIView!
    
    @IBOutlet weak var usdTitleLabel: UILabel!
    @IBOutlet weak var usdDescriptLabel: UILabel!
    @IBOutlet weak var usdRateLabel: UILabel!
    @IBOutlet weak var usdRateFloatLabel: UILabel!
    @IBOutlet weak var lineUSDView: UIView!
    
    @IBOutlet weak var gbpTitleLabel: UILabel!
    @IBOutlet weak var gbpDescriptLabel: UILabel!
    @IBOutlet weak var gbpRateLabel: UILabel!
    @IBOutlet weak var gbpRateFloatLabel: UILabel!
    @IBOutlet weak var lineGBPView: UIView!
    
    @IBOutlet weak var eurTitleLabel: UILabel!
    @IBOutlet weak var eurDescriptLabel: UILabel!
    @IBOutlet weak var eurRateLabel: UILabel!
    @IBOutlet weak var eurRateFloatLabel: UILabel!
    @IBOutlet weak var lineEURView: UIView!
    
    @IBOutlet weak var dateUpdatedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
    
    func initUI() {
        self.contentCurrencyView.layer.cornerRadius = 15
        self.contentCurrencyView.layer.borderWidth = 1
        self.contentCurrencyView.layer.borderColor = UIColor.black.cgColor
    }
    
    func displayCurrencyBitcoin(currency: BitcoinEntity) {
        self.usdTitleLabel.text = "\(currency.usd!.code) " + "\(currency.usd!.symbol.decodingUnicodeCharacters)"
        self.usdDescriptLabel.text = "(\(currency.usd!.descriptionCurrency))"
        self.usdRateLabel.text = "Rate : " + currency.usd!.rate
        self.usdRateFloatLabel.text = "Rate Float : " + "\(currency.usd!.rate_float)"
        
        self.gbpTitleLabel.text = "\(currency.gbp!.code) " +  "\(String(describing: currency.gbp!.symbol.htmlAttributedString.string))"
        self.gbpDescriptLabel.text = "(\(currency.gbp!.descriptionCurrency))"
        self.gbpRateLabel.text = "Rate : " + currency.gbp!.rate
        self.gbpRateFloatLabel.text = "Rate Float : " + "\(currency.gbp!.rate_float)"
        
        self.eurTitleLabel.text = "\(currency.eur!.code) " +  "\(String(describing: currency.eur!.symbol.htmlAttributedString.string))"
        self.eurDescriptLabel.text = "(\(currency.eur!.descriptionCurrency))"
        self.eurRateLabel.text = "Rate : " + currency.eur!.rate
        self.eurRateFloatLabel.text =  "Rate Float : " + "\(currency.eur!.rate_float)"
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let timeDate = formatter.date(from: currency.updatedISO) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let timeUpdated = dateFormatter.string(from: timeDate)
        
        self.dateUpdatedLabel.text = "Time : " + timeUpdated
    }

}
