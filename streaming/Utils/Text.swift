//
//  Text.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

class Text: UILabel {
    
    var content: NSMutableAttributedString? {
        didSet {
            self.write()
        }
    }
    var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
    }
    
    convenience init(font: UIFont? = UIFont(name: "Roboto", size: 10), content: NSMutableAttributedString?, color: UIColor? = .black) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.textColor = color
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.font = font
        self.content = content
        self.write() // show text with attribuutes applied
        self.setNeedsDisplay()
        
    }
    
    func write() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        content?.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content!.length))
        self.attributedText = content
    }
}

