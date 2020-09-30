//
//  UIImage+Extensions.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}


extension UIImageView {
    func setImageFromURL(imageURL: String? = nil, completion: ((Bool) -> Void)? = nil) {
        
        // Use only HTTPS to avoid errors
        guard let imageURL = imageURL?.replacingOccurrences(of: "http://", with: "https://") else {
            return
        }
        URLSession.shared.dataTask(with: URL(string:imageURL)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        }).resume()
    }
}
