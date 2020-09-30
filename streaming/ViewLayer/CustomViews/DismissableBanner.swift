//
//  DismissableBanner.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

// This banner could be used to display message or toast, hence the abstraction
class DismissableBanner: UIView {

    var text: Text! {
        didSet {
            self.setup()
        }
    }
    
    lazy var dismiss: UIButton = {
        let btn = UIButton(type: .custom)
        let size = CGSize(width: 15, height: 15)
        btn.setImage(UIImage(named: "ic_close")?.resize(to: size).withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .white
        btn.willSetConstraints()
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setup()
    }
    
    private func setup() {
        self.backgroundColor = Colors.pink
        self.dismiss.backgroundColor = Colors.grey
        self.addSubview(text)
        self.addSubview(dismiss)
        
        NSLayoutConstraint.activate([
            dismiss.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dismiss.heightAnchor.constraint(equalToConstant: 20),
            dismiss.widthAnchor.constraint(equalToConstant: 20),
            dismiss.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
//            text.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            text.trailingAnchor.constraint(equalTo: dismiss.leadingAnchor, constant: -5),
            text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            text.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        self.dismiss.addTarget(self, action: #selector(self.remove), for: .touchUpInside)
    }
    
    @objc func remove() {
        self.removeFromSuperview()
    }
    
}
