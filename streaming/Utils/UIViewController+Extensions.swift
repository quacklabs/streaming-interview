//
//  UIViewController+Extensions.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrapInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
