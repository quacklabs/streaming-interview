//
//  Recent.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

class Recent: UITableView {
    
    var action: CarouselDelegate?
    
    var items: [SliderItem]? {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
        backgroundColor = .clear
        register(RecentCell.self, forCellReuseIdentifier: RecentCell.identifier)
        dataSource = self
        delegate = self
    }
}


extension Recent: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier, for: indexPath) as! RecentCell
        if self.items != nil {
            cell.item = self.items?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.action?.selected()
    }
}

class RecentCell: UITableViewCell {
    static let identifier = "recent"
    
    var duration: Text!
    var title: Text!
    var subtitle: Text!
    lazy var elipsis: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ic_elipsis")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        image.willSetConstraints()
        return image
    }()
    
    var item: SliderItem! {
        didSet {
            setup()
        }
    }
    
    func setup() {
        self.backgroundColor = .clear
        title = Text(font: UIFont(name: "Roboto", size: 14)?.bold,content: item.title.capitalized.attributed, color: .white)
        title.willSetConstraints()
        
        subtitle = Text(font: UIFont(name: "Roboto", size: 12), content: item.artiste.capitalized.attributed, color: .white)
        subtitle.willSetConstraints()
        
        duration = Text(content: item.duration.attributed, color: .white)
        duration.willSetConstraints()
        
        self.addSubviews([title, subtitle, duration, elipsis])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            elipsis.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            elipsis.widthAnchor.constraint(equalToConstant: 30),
            elipsis.heightAnchor.constraint(equalToConstant: 10),
            elipsis.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            duration.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            duration.trailingAnchor.constraint(equalTo: elipsis.leadingAnchor, constant: -5)
        ])
        self.layoutIfNeeded()
//        duration.sizeToFit()
        
    }
}
