//
//  String+Extensions.swift
//  streaming
//
//  Created by Mark Boleigha on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import Foundation

extension String {
    
    var length: Int {
        return self.count
    }
    
    func substring(_ from: Int, _ length: Int? = nil) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return (length != nil && self.length > 0) ? String(self[fromIndex ..< self.index(fromIndex, offsetBy: length!)]) : String(self[fromIndex...])
    }
    
    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}
