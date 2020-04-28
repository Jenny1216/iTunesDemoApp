//
//  Artist.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import Foundation

struct Artist: Codable, Hashable {
    var artistId: Int?
    var kind: String?
    var artistName: String?
    var primaryGenreName: String?  //genre
    var artworkUrl100: String?  //Picture of the Artwork
    var trackViewUrl: String?  //link to iTunes
    var previewUrl: String?
    var trackName: String?  // name
}
