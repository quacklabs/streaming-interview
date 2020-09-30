//
//  MiniPlayer.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

protocol MiniPlayerDelegate {
    func toggle()
}

class MiniPlayer : UIView {
    
    lazy var albumImage: UIImageView = {
        let img = UIImageView()
        img.willSetConstraints()
        return img
    }()
    
    lazy var trackName: Text = {
        let txt = Text(font: UIFont(name: "Roboto", size: 13)?.bold, content: nil, color: .white)
        txt.willSetConstraints()
        return txt
    }()
    
    lazy var artiseName: Text = {
        let txt = Text(font: UIFont(name: "Roboto", size: 13), content: nil, color: .white)
        txt.willSetConstraints()
        return txt
    }()
    
    lazy var playPause: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "ic_play_filled")!.resize(to: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.imageView?.tintColor = Colors.yellow
        btn.willSetConstraints()
        return btn
    }()
    
    lazy var prevBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "ic_play_prev")!.resize(to: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.imageView?.tintColor = Colors.yellow
        btn.willSetConstraints()
        return btn
    }()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "ic_play_next")!.resize(to: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.imageView?.tintColor = Colors.yellow
        btn.willSetConstraints()
        return btn
    }()
    
    lazy var progressBar: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = Colors.yellow
        view.willSetConstraints()
        return view
    }()
        
    var isCurrentlyPlayingHidden = false // if we are playing while hiding the miniPlayer. we can hide the mini player without stopping the music
    // Our custom view from the XIB file
    var controlsView : UIView!
    var delegate: MiniPlayerDelegate?
    
    // Hide our miniPlayer on track stop playing
    func hide() {
        isCurrentlyPlayingHidden = true
        self.isHidden = true
    }
    
    // Show controller on Track start playing
    //
    func show(){
        isCurrentlyPlayingHidden = false
        self.isHidden = false
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    func xibSetup() {
        self.backgroundColor = UIColor.black
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor.white.cgColor
        controlsView = UIView()
        controlsView.willSetConstraints()
        
        controlsView.addSubviews([
            albumImage, trackName, nextBtn, prevBtn,
            artiseName, playPause
        ])
        
        addSubviews([progressBar, controlsView])
        self.align()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.toggle))
        swipe.direction = .down
        
        self.addGestureRecognizer(swipe)
    }
    
    private func align() {
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 3),
            progressBar.widthAnchor.constraint(equalTo: self.widthAnchor),
            progressBar.bottomAnchor.constraint(equalTo: controlsView.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            controlsView.heightAnchor.constraint(equalToConstant: 57),
            controlsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            controlsView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            controlsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            albumImage.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 15),
            albumImage.topAnchor.constraint(equalTo: controlsView.topAnchor),
            albumImage.bottomAnchor.constraint(equalTo: controlsView.bottomAnchor),
            albumImage.widthAnchor.constraint(equalToConstant: 57),
            
            trackName.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 5),
            trackName.bottomAnchor.constraint(equalTo: albumImage.centerYAnchor),
            trackName.trailingAnchor.constraint(equalTo: prevBtn.leadingAnchor),
            artiseName.topAnchor.constraint(equalTo: albumImage.centerYAnchor),
            artiseName.leadingAnchor.constraint(equalTo: trackName.leadingAnchor),
            
            nextBtn.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -15),
            nextBtn.heightAnchor.constraint(equalToConstant: 30),
            nextBtn.widthAnchor.constraint(equalToConstant: 30),
            nextBtn.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor),
            
            playPause.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor),
            playPause.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor, constant: -10),
            playPause.heightAnchor.constraint(equalToConstant: 30),
            playPause.widthAnchor.constraint(equalToConstant: 30),
            
            prevBtn.widthAnchor.constraint(equalToConstant: 30),
            prevBtn.heightAnchor.constraint(equalToConstant: 30),
            prevBtn.trailingAnchor.constraint(equalTo: playPause.leadingAnchor, constant: -10),
            prevBtn.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor),
            
        ])
    }
    
    @objc func toggle() {
        self.delegate?.toggle()
    }
    
    func play() {
        progressBar.progress = 0.8
        self.albumImage.image = UIImage(named: "unnamed")
        trackName.content = "Track name".attributed
        artiseName.content = "Artiste name".attributed
    }
}
