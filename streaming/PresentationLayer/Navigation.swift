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
    var miniPlayer: MiniPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.backgroundColor = .black
        self.createTabNavigationMenu()
    }
    
    private func createTabNavigationMenu() {
        // Create our tab view
        let frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0)
        self.customTabBar = TabMenu(frame: frame, tabMenuItems: self.menuItems)
        self.customTabBar.willSetConstraints()
        self.customTabBar.delegate = self
        
        //create the Mini Player
        miniPlayer = MiniPlayer(frame: .zero)
        miniPlayer.willSetConstraints()
        miniPlayer.delegate = self
//        miniPlayer.hide()
        
        // Add it to the view
        self.view.addSubviews([miniPlayer, self.customTabBar])
        
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: 56),
            self.customTabBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            miniPlayer.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: -1),
            miniPlayer.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: 1),
            miniPlayer.heightAnchor.constraint(equalToConstant: 50),
            miniPlayer.bottomAnchor.constraint(equalTo: customTabBar.topAnchor)
            
        ])
        
        self.viewControllers = menuItems.map({ $0.controller })
        self.customTabBar.clipsToBounds = false
        self.customTabBar.activateTab(viewId: self.customTabBar.activeTabIndex)
        
        miniPlayer.play()
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


extension Navigation: MiniPlayerDelegate {
    func toggle() {
        miniPlayer.hide()
    }
}
