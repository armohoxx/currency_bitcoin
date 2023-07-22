//
//  CurrencyViewController.swift
//  currency_btc
//
//  Created Phattarapon Jungtakarn on 19/7/2566 BE.
//  Copyright © 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown

class CurrencyViewController: UIViewController {

	var presenter: CurrencyPresenterProtocol?
    var currencyBitcoinData: [BitcoinEntity] = []
    let dropDown = DropDown()
    var remainingTime: Int = 60 // Initial time in seconds
    var timer: Timer?
    let fontDetail = UIFont.systemFont(ofSize: 16.0, weight: .regular)

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionViewCurrency: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var tiltleChangeCurrencyLabel: UILabel!
    @IBOutlet weak var selectCurrencyTextField: UITextField!
    @IBOutlet weak var inputCurrencyTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionViewCurrencyHeightConstraint: NSLayoutConstraint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.dropDown.hide()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.notifyFetchCurrencyBitcoin()
        self.startCountdownTimer()
        self.initUI()
    }
    
    func initUI() {
        self.activityIndicator.startAnimating()
        self.setupNavigationBar()
        self.setupActionTextField()
        let nibCurrencyCell = UINib(nibName: "CurrencyCell", bundle: nil)
        self.collectionViewCurrency.register(nibCurrencyCell, forCellWithReuseIdentifier: "CurrencyCell")
        self.selectCurrencyTextField.setRightImage(imageName: "ic_dropdown", width: 16, height: 16)
        self.inputCurrencyTextField.delegate = self
        self.selectCurrencyTextField.text = "USD"
        self.calculateButton.layer.cornerRadius = 15
        self.calculateButton.tintColor = UIColor.white
        self.calculateButton.backgroundColor = UIColor.link
        self.selectCurrencyTextField.layer.borderWidth = 1
        self.selectCurrencyTextField.layer.cornerRadius = 10
        self.inputCurrencyTextField.layer.borderWidth = 1
        self.inputCurrencyTextField.layer.cornerRadius = 10
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Currency"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0),
                                                                    NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    func setupActionTextField() {
        DispatchQueue.main.async {
            self.selectCurrencyTextField.addTarget(self, action: #selector(self.onClickselectCurrencyDropDrown(_:)), for: .editingDidBegin)
        }
    }
    
    func initUIMenu() {
        self.dropDown.textColor = UIColor.black
        self.dropDown.textFont = UIFont.systemFont(ofSize: 16)
        self.dropDown.backgroundColor = UIColor.white
        self.dropDown.cellHeight = 35
        self.dropDown.selectionBackgroundColor = UIColor.white
        self.dropDown.selectedTextColor = UIColor.black
        self.dropDown.layer.cornerRadius = 8
        
        self.dropDown.direction = .bottom
        self.dropDown.bottomOffset = CGPoint(x: 0, y: 50)
        self.dropDown.topOffset = CGPoint(x: 0, y: 0)
        
        self.dropDown.cellNib = UINib(nibName: "MenuDropDownCell", bundle: nil)
        self.dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MenuDropDownCell else { return }
            cell.optionLabel.text = item
        }
        
        self.dropDown.cancelAction = { [unowned self] in
            self.view.endEditing(true)
        }
    }

    @IBAction func onClickCalculateButton(_ sender: UIButton) {
        for data in self.currencyBitcoinData {
            if self.inputCurrencyTextField.text?.count != 0 {
                if self.selectCurrencyTextField.text == data.usd?.code ?? "" {
                    self.resultLabel.text = "Result BTC Amount : " + "\((Float64(self.inputCurrencyTextField.text!)!) / Float64(data.usd?.rate_float ?? 0))"
                } else if self.selectCurrencyTextField.text == data.gbp?.code ?? "" {
                    self.resultLabel.text = "Result BTC Amount : " + "\((Float64(self.inputCurrencyTextField.text!)!) / Float64(data.gbp?.rate_float ?? 0))"
                } else if self.selectCurrencyTextField.text == data.eur?.code ?? "" {
                    self.resultLabel.text = "Result BTC Amount : " + "\((Float64(self.inputCurrencyTextField.text!)!) / Float64(data.eur?.rate_float ?? 0))"
                }
            } else {
                let alert = UIAlertController(title: "Alert?", message: "Please insert input", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func onClickselectCurrencyDropDrown(_ textField: UITextField) {
        self.dropDown.anchorView = textField
        
        if self.currencyBitcoinData.count != 0 {
            for data in self.currencyBitcoinData {
                self.dropDown.dataSource = [data.usd?.code ?? "", data.gbp?.code ?? "", data.eur?.code ?? ""]
            }
            
            self.dropDown.show()
            
        } else {
            self.dropDown.dataSource = ["No data currency"]
            self.dropDown.show()
        }
        
        self.dropDown.selectionAction = { index,title in
            self.selectCurrencyTextField.text = title
            self.view.endEditing(true)
            
        }
    }
    
    func startCountdownTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
    @objc func updateTimer() {
        remainingTime -= 1
        
        if remainingTime <= 0 {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
            remainingTime = 60
        }
        
        self.updateLabelTimer()
    }
        
    func updateLabelTimer() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        countdownLabel.text = "Update Data in : " + formattedTime
    }
    
}

extension CurrencyViewController: CurrencyViewProtocol {
    
    func displayCurrencyBitcoin(currencyData: [BitcoinEntity]) {
        self.currencyBitcoinData = currencyData
        
        for data in currencyData {
            self.titleLabel.text = (data.chartName ?? "Bitcoin") + " Rate NOW!"
        }
        
        self.tiltleChangeCurrencyLabel.text = "Change Currency To BTC"
        self.collectionViewCurrency.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
}

extension CurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.dropDown.hide()
        return true
    }
    
}

extension CurrencyViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currencyBitcoinData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        cell.displayCurrencyBitcoin(currency: self.currencyBitcoinData[indexPath.row])
        
        return cell
    }
    
}

extension CurrencyViewController: UICollectionViewDelegateFlowLayout {
    
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
            
            let usdCodeSize: CGFloat = usdCode.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let usdDescriptSize: CGFloat = usdDescript.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let usdRateSize: CGFloat = usdRate.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let usdRateFloatSize: CGFloat = "\(usdRateFloat)".heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpCodeSize: CGFloat = gbpCode.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpDescriptSize: CGFloat = gbpDescript.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpRateSize: CGFloat = gbpRate.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let gbpRateFloatSize: CGFloat = "\(gbpRateFloat)".heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurCodeSize: CGFloat = eurCode.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurDescriptSize: CGFloat = eurDescript.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurRateSize: CGFloat = eurRate.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let eurRateFloatSize: CGFloat = "\(eurRateFloat)".heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            let dateUpdateSize: CGFloat = dateUpdate.heightWithConstrainedWidth(width: self.collectionViewCurrency.frame.width - ConstraintCurrencyPage.DefaultConstraintLeftRight.cgFloatValue, font: self.fontDetail)
            
            let height = (usdCodeSize + usdDescriptSize + usdRateSize + usdRateFloatSize) + (gbpCodeSize + gbpDescriptSize + gbpRateSize + gbpRateFloatSize) + (eurCodeSize + eurDescriptSize + eurRateSize + eurRateFloatSize) + dateUpdateSize + ConstraintCurrencyPage.DefaultSizeCellCurrency.cgFloatValue
            
            self.collectionViewCurrencyHeightConstraint.constant = height

            return CGSize(width: self.collectionViewCurrency.frame.width, height: height)
        } else {
            return CGSize(width: self.collectionViewCurrency.frame.width, height: 0)
        }
    }
    
}

