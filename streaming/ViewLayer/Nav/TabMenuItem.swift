//
//  TabMenuItem.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit


class TabMenuItem: UIView {
    var icon: UIImage?
    var controller: UIViewController?
    
    var displayTitle: UILabel = UILabel(frame: .zero)
    var iconView: UIImageView = UIImageView(frame: .zero)
    
    var isSelected: Bool = false {
        didSet {
            if self.isSelected {
                self.iconView.tintColor = Colors.yellow
                self.iconView.image = self.icon
                self.displayTitle.textColor = Colors.yellow
            } else {
                self.iconView.image = self.icon
                self.iconView.tintColor = .white
                self.displayTitle.textColor = .white
                
            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.iconView.willSetConstraints()
        
        self.displayTitle.font = UIFont(name: "Roboto", size: 13)
        self.displayTitle.textColor = .white
        self.displayTitle.willSetConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(menuItem: Menu, asActive: Bool, iconSize: CGSize? = nil) {
        self.init(frame: .zero)
        
        self.controller = menuItem.controller
        self.icon = menuItem.icon
        self.isSelected = asActive
        
        self.iconView.image = self.icon?.withRenderingMode(.alwaysTemplate)
        self.iconView.tintColor = self.isSelected ? Colors.yellow : .white
        self.displayTitle.text = menuItem.title
        self.displayTitle.sizeToFit()
        
        addSubview(self.iconView)
        addSubview(self.displayTitle)
        
        NSLayoutConstraint.activate([
            self.iconView.heightAnchor.constraint(equalToConstant: iconSize?.height ?? 30),
            self.iconView.widthAnchor.constraint(equalToConstant: iconSize?.width ?? 30),
            self.iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.displayTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.displayTitle.topAnchor.constraint(equalTo: self.iconView.bottomAnchor, constant: 3.26)
        ])
    }
}


