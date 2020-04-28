//
//  Constants.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import Foundation

struct Constants {
    
    static let searchReuseCellIdentifier = "SearchContentCell"
    static let favoriteReuseCellIdentifier = "FavoritesContentCell"
    static let searchCellNibName = "SearchContentCell"
    static let favoriteCellNibName = "FavoritesContentCell"
    
    struct Endpoints {
        static let baseUrl = "https://itunes.apple.com"
        static let searchTerm = "/search?term="
    }
}
