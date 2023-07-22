//
//  ReadOnlyTextField.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 22/7/2566 BE.
//

import UIKit

class ReadOnlyTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Avoid keyboard to show up
        self.inputView = UIView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Avoid keyboard to show up
        self.inputView = UIView()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Avoid cut and paste option show up
        if (action == #selector(self.cut(_:))) {
            return false
        } else if (action == #selector(self.paste(_:))) {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
    
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
         if gestureRecognizer.isKind(of: UILongPressGestureRecognizer.self) {
                  gestureRecognizer.isEnabled = false
         }
        
        return super.addGestureRecognizer(gestureRecognizer)
    }

}
