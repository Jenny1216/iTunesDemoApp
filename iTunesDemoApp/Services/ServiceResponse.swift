//
//  ServiceResponse.swift
//  iTunesDemoApp
//
//  Created by Jinisha Savani on 4/26/20.
//  Copyright © 2020 Jinisha Savani. All rights reserved.
//

import Foundation

struct ServiceResponse {
    
    func fetchResponse(with searchString: String, handler: @escaping (Result<Feed?, Error>) -> Void) {
        
        let searchString = searchString.replacingOccurrences(of: " ", with: "+")
        let urlString = Constants.Endpoints.baseUrl + Constants.Endpoints.searchTerm + searchString
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else {
                handler(.failure(error!));
                return }
            
            let decoder = JSONDecoder()
            let response = try? decoder.decode(Feed.self, from: data)
            print(response)
            handler(.success(response))
        }
        .resume()
    }
}
