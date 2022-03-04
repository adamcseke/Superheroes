//
//  RestClient.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 21..
//  Copyright © 2019. levivig. All rights reserved.
//

import Alamofire
import Foundation

enum GithubError: Error {
    case wrongURL
}

final class RestClient {
    static let shared = RestClient()
    
    struct Constants {
        static let baseUrl = "https://superheroapi.com/api.php/" + apiKey
        static let apiKey = "2915390945376495"
    }
    
    private init() {}
   
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(GithubError.wrongURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch let exepction {
                    DispatchQueue.main.async {
                        completion(.failure(exepction))
                        print(String(describing: exepction))
                    }
                }
            }
        }
        task.resume()
    }
    
    func request<T: Codable>(urlString: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(GithubError.wrongURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode([T].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch let exepction {
                    DispatchQueue.main.async {
                        completion(.failure(exepction))
                        print(String(describing: exepction))
                    }
                }
            }
        }
        task.resume()
    }
}
