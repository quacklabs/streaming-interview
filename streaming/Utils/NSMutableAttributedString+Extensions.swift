//
//  NSMutableAttributedString+Extensions.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import Foundation


extension NSMutableAttributedString {
    func withAttributes(attributes: [NSRange : [NSAttributedString.Key: AnyHashable]]) -> NSMutableAttributedString {
        attributes.forEach({
            let attribute = $0.value as [NSAttributedString.Key: AnyHashable]
            let range = $0.key
            
            attribute.forEach({ (key, value) in
                self.addAttribute(key, value: value, range: range)
            })
        })
        return self
    }
}
