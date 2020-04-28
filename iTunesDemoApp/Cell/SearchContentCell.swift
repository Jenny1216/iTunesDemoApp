//
//  SearchContentCell.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import UIKit

protocol SearchContentCellDelegate: class {
    func addToFavorites(favorite: Artist)
}

class SearchContentCell: UITableViewCell {
    
    var artist: Artist?
    
    weak var delegate: SearchContentCellDelegate?
    @IBOutlet weak var artworkImg: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var itunesLink: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        delegate?.addToFavorites(favorite: artist!)
    }
}
