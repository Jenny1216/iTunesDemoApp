//
//  Feed.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var resultCount: Int?
    var results: [Artist]?
}
