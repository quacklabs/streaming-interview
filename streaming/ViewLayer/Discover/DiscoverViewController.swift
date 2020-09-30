//
//  DiscoverViewController.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    lazy var topDismissableBanner: DismissableBanner = {
        let view = DismissableBanner()
        view.willSetConstraints()
        return view
    }()
    
    lazy var bannerImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "banner"))
        view.willSetConstraints()
        return view
    }()
    
    lazy var magicBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_wand"), for: .normal)
        btn.backgroundColor = Colors.yellow
        btn.setTitle("Magic Playlist", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto", size: 14)
        btn.semanticContentAttribute = (UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft) ? .forceLeftToRight : .forceRightToLeft
        btn.layer.cornerRadius = 4
        btn.willSetConstraints()
        return btn
    }()
    
    lazy var moodBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = Colors.pink
        btn.setTitle("Mood", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Roboto", size: 14)
        btn.setImage(UIImage(named: "ic_play_filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .white
        btn.layer.cornerRadius = 4
        btn.semanticContentAttribute = (UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft) ? .forceLeftToRight : .forceRightToLeft
        btn.willSetConstraints()
        return btn
    }()
    
    lazy var slider: Slider = {
        let view = Slider()
        view.willSetConstraints()
        return view
    }()
    
    lazy var recent: Recent = {
        let view = Recent()
        view.willSetConstraints()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews([
            bannerImage, topDismissableBanner,
            magicBtn, moodBtn,
            slider
        ])
        self.align()
        self.setupBanner()
        self.setupSlider()
        self.setupRecent()
    }
    
    private func align() {
        NSLayoutConstraint.activate([
            topDismissableBanner.heightAnchor.constraint(equalToConstant: 30),
            topDismissableBanner.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            topDismissableBanner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topDismissableBanner.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImage.heightAnchor.constraint(equalToConstant: 250),
            
            magicBtn.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 15),
            magicBtn.heightAnchor.constraint(equalToConstant: 30),
            magicBtn.widthAnchor.constraint(equalToConstant: (view.frame.size.width / 2) - 30),
            magicBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            moodBtn.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 15),
            moodBtn.heightAnchor.constraint(equalToConstant: 30),
            moodBtn.widthAnchor.constraint(equalToConstant: (view.frame.size.width / 2) - 30),
            moodBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            slider.heightAnchor.constraint(equalToConstant: 140),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            slider.topAnchor.constraint(equalTo: moodBtn.bottomAnchor, constant: 15),
        ])
    }
    
    // This part could be moved elsewhere and optimised better. just here cuz this is a quick demo
    private func setupBanner() {
        let text = "Almost There!, Finish setting up your profile and you are good to go"
        let boldRange = (text as NSString).range(of: "Almost There!", options: .caseInsensitive)
        
        let attribs: [NSRange : [NSAttributedString.Key: AnyHashable]] = [boldRange : [NSAttributedString.Key.font: UIFont(name: "Roboto", size: 11)?.bold ]]
        topDismissableBanner.text = Text(
            font: UIFont(name: "Roboto", size: 11),
            content: NSMutableAttributedString(string: text).withAttributes(attributes: attribs),
            color: UIColor.white
        )
        topDismissableBanner.text.numberOfLines = 1
        topDismissableBanner.text.sizeToFit()
    }
    
    private func setupSlider() {
        // this will be a real api call
        let testURL = Bundle.main.url(forResource:"mock", withExtension: "json")!
        
        guard let testData = try? Data(contentsOf: testURL) else {
            print("failed to parse mock json")
            return
        }
        
        guard let json = try? JSONDecoder().decode([SliderItem].self, from: testData) else {
            print("failed to decode")
            return
        }
        slider.action = self
        slider.items = json
    }
    
    private func setupRecent() {
        let recentView = UIView()
        recentView.willSetConstraints()
        
        let icon = UIImageView(image: UIImage(named: "ic_music")?.withRenderingMode(.alwaysTemplate))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = Colors.yellow
        icon.willSetConstraints()
        
        let headerTitle = Text(font: UIFont(name: "Roboto", size: 17)?.bold, content: "New This Week".attributed, color: .white)
        headerTitle.willSetConstraints()
        
        recentView.addSubviews([icon, headerTitle, recent])
        
        self.view.addSubview(recentView) // will change to a stack view insert to make this scale on smaller devices in a real scenario
        
        NSLayoutConstraint.activate([
            recentView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            recentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            recentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            icon.topAnchor.constraint(equalTo: recentView.topAnchor),
            icon.leadingAnchor.constraint(equalTo: recentView.leadingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
            headerTitle.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
            recent.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 5),
            recent.bottomAnchor.constraint(equalTo: recentView.bottomAnchor),
            recent.leadingAnchor.constraint(equalTo: recentView.leadingAnchor),
            recent.trailingAnchor.constraint(equalTo: recentView.trailingAnchor)
        ])
        headerTitle.sizeToFit()
        
        let testURL = Bundle.main.url(forResource:"mock", withExtension: "json")!
        
        guard let testData = try? Data(contentsOf: testURL) else {
            print("failed to parse mock json")
            return
        }
        
        guard let json = try? JSONDecoder().decode([SliderItem].self, from: testData) else {
            print("failed to decode")
            return
        }
        recent.action = self
        recent.items = json
    }

}


extension DiscoverViewController: CarouselDelegate {
    func selected() {
        let alert = UIAlertController(title: "OK", message: "This track information will play", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            alert.dismiss(animated: false, completion: nil)
            return
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
