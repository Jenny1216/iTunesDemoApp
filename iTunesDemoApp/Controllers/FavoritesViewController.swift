//
//  FavoritesViewController.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritesArray = [Artist]()
    var label = UILabel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.favoriteCellNibName, bundle: nil), forCellReuseIdentifier: Constants.favoriteReuseCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.separatorStyle = .none
        let tabBarVC = tabBarController as! TabBarViewController
        if tabBarVC.favoritesArray != nil {
            favoritesArray = tabBarVC.favoritesArray!
            label.isHidden = true
        } else {
            label.isHidden = false
            label.text = "Your favorites will appear here."
            label.textColor = .systemGray
            label.heightAnchor.constraint(equalToConstant: 50)
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
            label.textAlignment = .center
            self.tableView.backgroundView = label
        }
        tableView.reloadData()
    }
}

//MARK:- TableViewMethods
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritesArray.isEmpty {
            return 0
        } else {
            return favoritesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteReuseCellIdentifier, for: indexPath) as! FavoritesContentCell
        cell.delegate = self
        let artist = favoritesArray[indexPath.row]
        cell.trackName.text = artist.trackName
        cell.genreLabel.text = artist.primaryGenreName
        cell.itunesLink.text = artist.trackViewUrl
        let url = URL(string: artist.artworkUrl100!)
        cell.tag = indexPath.row
        let task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if cell.tag == indexPath.row {
                    cell.artworkImg.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        cell.artist = artist
        return cell
    }
}

extension FavoritesViewController: FavoritesContentCellDelegate {
    func removeFavorites(removeFavorite artist: Artist, at tag: Int) {
        let tabBarVC = tabBarController as! TabBarViewController
        var array = tabBarVC.favoritesArray
        if array!.contains(artist) {
            favoritesArray.remove(at: tag)
            array = favoritesArray
            self.tableView.reloadData()
        }
    }
}
