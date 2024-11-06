//
//  MusicRemoteDatasource.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import Foundation

class MusicRemoteDatasource{
    func searchMusic(by artist: String, completion: @escaping (Result<SearchDTO, Error>) -> Void){
        
        var component = URLComponents(string: "https://itunes.apple.com")
        component?.path = "/search"
        component?.queryItems = [
            URLQueryItem(name: "term", value: artist)
        ]
        
        guard let url = component?.url else{
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
                
            if error != nil {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do{
                let resposne = try JSONDecoder().decode(SearchDTO.self, from: data)
                completion(.success(resposne))
            }catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
