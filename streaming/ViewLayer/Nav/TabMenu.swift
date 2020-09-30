//
//  TabMenu.swift
//  streaming
//
//  Created by Mark Boleigha on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

protocol  TabMenuDelegate: class {
    func itemTapped(item: Int)
}

class TabMenu: UIView {

    var delegate: TabMenuDelegate?
    var previousIndex: Int! = 0
    var activeTabIndex: Int = 2 {
        willSet {
            self.previousIndex = self.activeTabIndex
        }
    }
    
    var itemWidth: CGFloat!
    
    var borderLayer: CAShapeLayer! = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, tabMenuItems: [Menu]) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.black
//        self.addShadow(color: UIColor.black.withAlphaComponent(0.25), withOffset: CGSize(width: 0, height: -3))
        self.tintColor = Colors.yellow
        
        self.itemWidth = self.bounds.width / CGFloat(tabMenuItems.count)
        
        for i in 0 ..< tabMenuItems.count {
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = TabMenuItem(menuItem: tabMenuItems[i], asActive: (i == self.activeTabIndex) ? true : false, iconSize: nil)
            itemView.tag = i
            
            self.addSubview(itemView)
            itemView.willSetConstraints()
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleItemTapped)))
        }
        self.borderLayer.fillColor = UIColor.clear.cgColor
        self.borderLayer.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor
        //        self.borderLayer.lineWidth = 0.5
        self.borderLayer.frame = self.bounds
        self.borderLayer.shadowOpacity = 0.7
        self.borderLayer.shadowRadius = 5
        self.layer.addSublayer(self.borderLayer)
    }
    
    @objc func handleItemTapped(_ gesture: UIGestureRecognizer) {
        self.activeTabIndex = self.subviews.firstIndex(of: gesture.view!)!
        self.switchTab(to: self.activeTabIndex)
    }
    
    public func switchTab(to newTabId: Int) {
        self.deactivateTab(viewId: self.previousIndex)
        self.activateTab(viewId: newTabId)
    }
    
    func deactivateTab(viewId: Int) {
        let tab = self.subviews[viewId] as! TabMenuItem
        tab.isSelected = false
        tab.iconView.image = tab.icon
    }
    
    func activateTab(viewId: Int) {
        let tab = self.subviews[viewId] as! TabMenuItem
        tab.isSelected = true
        
        DispatchQueue.main.async {
            self.activeTabIndex = viewId
            self.delegate?.itemTapped(item: viewId)
            self.setNeedsLayout()
            self.setNeedsDisplay()
            //            self.draw(self.frame)
        }
    }
}
