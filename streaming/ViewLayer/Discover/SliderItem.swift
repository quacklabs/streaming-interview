//
//  SliderItem.swift
//  streaming
//
//  Created by Sprinthub on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import Foundation

// conforming to codable because our API returns JSON
struct SliderItem: Codable {
    var title: String
    var artiste: String
    var art: String
    var duration: String
    
    enum CodingKeys: String, CodingKey {
        case title, artiste, art, duration
    }
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        artiste = try values.decode(String.self, forKey: .artiste)
        art = try values.decode(String.self, forKey: .art)
        duration = try values.decode(String.self, forKey: .duration)
    }
}
