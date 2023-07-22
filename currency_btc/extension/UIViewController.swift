//
//  UIViewController.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 19/7/2566 BE.
//

import UIKit

extension UIViewController {
    
    func setTabbarImage(_ imageNamed: String, title: String) {
        let icon = UIImage.init(named: imageNamed)?.withRenderingMode(.alwaysTemplate)
        let iconResize = icon?.resizeImage(targetSize: CGSize(width: 25, height: 25))
        let item = UITabBarItem.init(title: title, image: iconResize, tag: 0)
        self.tabBarItem = item
    }
    
    func setTabbarName(title: String) {
        self.tabBarItem.title = title
    }
    
    func attachModule(vc: UIViewController, toView: UIView) {
        vc.view.frame = toView.bounds
        vc.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        toView.addSubview(vc.view)
        self.addChild(vc)
    }
    
    func removeAttachModule() {
        self.children.forEach {
          $0.willMove(toParent: nil)
          $0.view.removeFromSuperview()
          $0.removeFromParent()
        }
    }
    
}
