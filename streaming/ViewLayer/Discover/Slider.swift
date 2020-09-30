//
//  Slider.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

protocol CarouselDelegate: class {
    func selected() -> Void
}

class Slider: UICollectionView {
    
    var action: CarouselDelegate?
    
    var items: [SliderItem]? {
        didSet {
            self.reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 130)
        flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        self.init(frame: .zero, collectionViewLayout: flowLayout)
        
        self.register(SliderCell.self, forCellWithReuseIdentifier: SliderCell.identifier)
        delegate = self
        dataSource = self
    }
}

extension Slider: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCell.identifier, for: indexPath) as! SliderCell
        if items != nil {
            cell.item = self.items?[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.action?.selected() // this can pass a track ID or object for use anywhere
    }
    
}


class SliderCell: UICollectionViewCell {
    static let identifier = "sliderCell"
    
    var image: UIImageView!
    var artisteName: Text!
    var title: Text!
    
    var item: SliderItem! {
        didSet {
            self.setup()
        }
    }
    
    private func setup() {
        image = UIImageView(image: UIImage(named: "unnamed"))
        image.willSetConstraints()
        
        artisteName = Text(content: item.artiste.uppercased().attributed, color: .white)
        artisteName.willSetConstraints()
        title = Text(content: item.title.attributed, color: .white)
        title.willSetConstraints()
        
        
        self.addSubviews([image, artisteName, title])
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 90),
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            artisteName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            artisteName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.topAnchor.constraint(equalTo: artisteName.bottomAnchor, constant: 5)
        ])
        
        image.layer.cornerRadius = 5
        image.setImageFromURL(imageURL: self.item.art, completion: nil)
        self.layoutIfNeeded()
    }
    
    
}
