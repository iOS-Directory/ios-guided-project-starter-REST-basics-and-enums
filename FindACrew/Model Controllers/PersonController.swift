//
//  PersonController.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import Foundation

enum NetworkError: Error {
case noData
case fetchDataFailed
case decodingError
}

class PersonController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://lambdaswapi.herokuapp.com")!
    private lazy var peopleURL = URL(string: "/api/people", relativeTo: baseURL)!
    
    
    func fetchPerson(withTerm searchTerm: String, completion: @escaping (Result<[Person], NetworkError>) -> Void ) {
        var urlComponent = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
        let query = URLQueryItem(name: "search", value: searchTerm)
        urlComponent?.queryItems = [query]
        
        guard let requestURL = urlComponent?.url else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                completion(.failure(.fetchDataFailed))
            }
            
            guard let data = data else {
                print("No data was received during the fetch request.")
                completion(.failure(.noData))
                return
            }
            
            do{
                let people = try JSONDecoder().decode([Person].self, from: data)
                completion(.success(people))
            }catch{
                print("Error decoding data: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
