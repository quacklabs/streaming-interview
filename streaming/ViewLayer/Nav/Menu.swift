//
//  Menu.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import Foundation
import UIKit

enum Menu: String, CaseIterable {
    case my_udux = "My uduX"
    case home, discover, connect, search
    
    var controller: UIViewController {
        switch self {
        case .my_udux:
            return MyMusicViewController().wrapInNavigation()
        case .home:
            return HomeViewController().wrapInNavigation()
        case .discover:
            return DiscoverViewController().wrapInNavigation()
        case .connect:
            return ConnectViewController().wrapInNavigation()
        case .search:
            return SearchViewController().wrapInNavigation()
        }
    }
    
    var icon: UIImage {
        switch self {
        case .my_udux:
            return UIImage(named: "ic_user")!.withRenderingMode(.alwaysTemplate)
        case .home:
            return UIImage(named: "ic_play")!.withRenderingMode(.alwaysTemplate)
        case .discover:
            return UIImage(named: "ic_discover")!.withRenderingMode(.alwaysTemplate)
        case .connect:
            return UIImage(named: "ic_connect")!.withRenderingMode(.alwaysTemplate)
        case .search:
            return UIImage(named: "ic_search")!.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var title: String {
        return self.rawValue.capitalized
    }
}
