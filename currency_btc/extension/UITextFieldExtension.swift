//
//  UITextFieldExtension.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 22/7/2566 BE.
//

import Foundation
import UIKit

extension UITextField {
    
    func setLeftImage(imageName: String, width: Double, height: Double) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 16.0, height: 16.0))
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .center
        imageView.backgroundColor = .clear

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        view.addSubview(imageView)
        view.backgroundColor = .clear
        self.leftView = imageView
        self.leftViewMode = .always
    }

    func setRightImage(imageName: String, width: Double, height: Double) {
        let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 16.0, height: 16.0))
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .center
        imageView.backgroundColor = .clear

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        view.addSubview(imageView)
        view.backgroundColor = .clear
        self.rightView = view
        self.rightViewMode = .always
    }
    
}
