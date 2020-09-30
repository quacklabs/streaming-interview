//
//  UIView+Extensions.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

extension UIView {
    func willSetConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    func addShadow(color: UIColor? = UIColor(red: 0.27, green: 0.32, blue: 0.33, alpha: 1), withOffset offset: CGSize? = CGSize(width: 0, height: 2)) {
        self.layer.shadowOffset = offset!
        self.layer.shadowColor = color!.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = false
    }
    
    func addSubviews(_ views: [Any]) {
        views.forEach({ self.addSubview($0 as! UIView) })
    }
}
