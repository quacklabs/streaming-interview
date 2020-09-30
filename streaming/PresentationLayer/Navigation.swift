//
//  Navigation.swift
//  streaming
//
//  Created by Mark Boleigha on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

class Navigation: UITabBarController {

    static let shared = Navigation()
    
    var customTabBar: TabMenu!
    let menuItems: [Menu] = [.my_udux, .home, .discover, .connect, .search]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.black
        
        tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.backgroundColor = Colors.black
        self.createTabNavigationMenu()
    }
    
    private func createTabNavigationMenu() {
        // Create our tab view
        let frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0)
        self.customTabBar = TabMenu(frame: frame, tabMenuItems: self.menuItems)
        self.customTabBar.willSetConstraints()
        self.customTabBar.delegate = self
        
        // Add it to the view
        self.view.addSubview(self.customTabBar)
        
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: 60),
//            self.customTabBar.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -10),
            self.customTabBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.viewControllers = menuItems.map({ $0.controller })
//        self.customTabBar.addShadow(color: UIColor.black, withOffset: CGSize(width: 0, height: -5))
        self.customTabBar.clipsToBounds = false
        self.customTabBar.activateTab(viewId: self.customTabBar.activeTabIndex)
    }

}

extension Navigation: TabMenuDelegate {
    func itemTapped(item: Int) {
        self.selectedIndex = item
        
        let anchor = CGFloat(self.customTabBar.itemWidth * CGFloat(item)) + 20
        let tab = self.customTabBar.subviews[item] as! TabMenuItem
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.circleImageView.image = tab.icon
//            self.circleViewCenter.constant = anchor
//            self.circleView.setNeedsDisplay()
//        })
    }
}
