//
//  SearchViewController.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var artistArray = [Artist]()
    var artistsArray = [[Artist]]()
    var favoritesArray = [Artist]()
    var artistDict: [String: [Artist]] {
        get {
            let dict = Dictionary(grouping: artistArray) { album in
                return album.kind ?? ""
            }
            return dict
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: Constants.searchCellNibName, bundle: nil), forCellReuseIdentifier: Constants.searchReuseCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    func getDataFromResponse(with searchString: String) {
        let serviceResponse = ServiceResponse()
        
        serviceResponse.fetchResponse(with: searchString) { [weak self] result in
            
            guard let self = self else { return }
            guard case .success(let data) = result else { return }
            guard let results = data?.results else { return }
            self.artistArray = results
            
            DispatchQueue.main.async {
                var array = [[Artist]]()
                let keys = self.artistDict.keys.sorted() { $0 > $1 }
                keys.forEach { key in
                    array.append(self.artistDict[key]!)
                }
                self.artistsArray = array
                self.tableView.reloadData()
            }
        }
    }
}

//MARK:- TableViewMethods
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return artistsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = artistDict.keys.sorted() { $0 > $1 }
        return String(title[section].prefix(1).capitalized + String(title[section].dropFirst()))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchReuseCellIdentifier, for: indexPath) as! SearchContentCell
        cell.delegate = self
        let artist = artistsArray[indexPath.section][indexPath.row]
        cell.trackName.text = artist.trackName
        cell.genreLabel.text = artist.primaryGenreName
        cell.itunesLink.text = artist.trackViewUrl
        let url = URL(string: artist.artworkUrl100!)
        cell.tag = indexPath.row
        
        let task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                if cell.tag == indexPath.row {
                    cell.artworkImg.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        cell.artist = artistsArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func refreshTableView(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}

//MARK:- SearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getDataFromResponse(with: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

//MARK:- SearchContentCellDelegate
extension SearchViewController: SearchContentCellDelegate {
    func addToFavorites(favorite: Artist) {
        if !(favoritesArray.contains(favorite)) {
            favoritesArray.append(favorite)
            let tabBarVC = tabBarController as! TabBarViewController
            tabBarVC.favoritesArray = favoritesArray
        }
    }
}
