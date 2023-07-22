//
//  HistoryViewController.swift
//  currency_btc
//
//  Created Phattarapon Jungtakarn on 20/7/2566 BE.
//  Copyright © 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryViewController: UIViewController {

	var presenter: HistoryPresenterProtocol?
    var currencyBitcoinData: [BitcoinEntity] = []
    let fontDetail = UIFont.systemFont(ofSize: 16.0, weight: .regular)

    @IBOutlet weak var tiletleHistoryLabel: UILabel!
    @IBOutlet weak var collectionViewHistory: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.notifyFetchHistoryCurrencyBitcoin()
        self.initUI()
    }
    
    func initUI() {
        self.setupNavigationBar()
        let nibCurrencyCell = UINib(nibName: "CurrencyCell", bundle: nil)
        self.collectionViewHistory.register(nibCurrencyCell, forCellWithReuseIdentifier: "CurrencyCell")
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "History"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0),
                                                                    NSAttributedString.Key.foregroundColor : UIColor.black]
    }

}

extension HistoryViewController: HistoryViewProtocol {
    
    func displayHistoryCurrencyBitcoin(currencyData: [BitcoinEntity]) {
        self.currencyBitcoinData = currencyData
    }
    
}

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currencyBitcoinData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        cell.displayCurrencyBitcoin(currency: self.currencyBitcoinData[indexPath.row])
        
        return cell
    }
    
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let usdCode = self.currencyBitcoinData[indexPath.row].usd?.code,
           let usdDescript = self.currencyBitcoinData[indexPath.row].usd?.descriptionCurrency,
           let usdRate = self.currencyBitcoinData[indexPath.row].usd?.rate,
           let usdRateFloat = self.currencyBitcoinData[indexPath.row].usd?.rate_float,
           let gbpCode = self.currencyBitcoinData[indexPath.row].gbp?.code,
           let gbpDescript = self.currencyBitcoinData[indexPath.row].gbp?.descriptionCurrency,
           let gbpRate = self.currencyBitcoinData[indexPath.row].gbp?.rate,
           let gbpRateFloat = self.currencyBitcoinData[indexPath.row].gbp?.rate_float,
           let eurCode = self.currencyBitcoinData[indexPath.row].eur?.code,
           let eurDescript = self.currencyBitcoinData[indexPath.row].eur?.descriptionCurrency,
           let eurRate = self.currencyBitcoinData[indexPath.row].eur?.rate,
           let eurRateFloat = self.currencyBitcoinData[indexPath.row].eur?.rate_float {
            let dateUpdate = self.currencyBitcoinData[indexPath.row].updated
            
            let usdCodeSize: CGFloat = usdCode.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let usdDescriptSize: CGFloat = usdDescript.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let usdRateSize: CGFloat = usdRate.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let usdRateFloatSize: CGFloat = "\(usdRateFloat)".heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpCodeSize: CGFloat = gbpCode.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpDescriptSize: CGFloat = gbpDescript.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpRateSize: CGFloat = gbpRate.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpRateFloatSize: CGFloat = "\(gbpRateFloat)".heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurCodeSize: CGFloat = eurCode.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurDescriptSize: CGFloat = eurDescript.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurRateSize: CGFloat = eurRate.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurRateFloatSize: CGFloat = "\(eurRateFloat)".heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let dateUpdateSize: CGFloat = dateUpdate.heightWithConstrainedWidth(width: self.collectionViewHistory.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            
            let height = (usdCodeSize + usdDescriptSize + usdRateSize + usdRateFloatSize) + (gbpCodeSize + gbpDescriptSize + gbpRateSize + gbpRateFloatSize) + (eurCodeSize + eurDescriptSize + eurRateSize + eurRateFloatSize) + dateUpdateSize + ConstraintCurrencyPage.DefaultSizeCellCurrency.cgFloatValue

            return CGSize(width: self.collectionViewHistory.frame.width, height: height)
        } else {
            return CGSize(width: self.collectionViewHistory.frame.width, height: 0)
        }
    }
    
}
