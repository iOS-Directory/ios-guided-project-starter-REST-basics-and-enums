//
//  PersonController.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import Foundation

class PersonController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
    case noData
    case fetchDataFailed
    case decodingError
    }
    
    private let baseURL = URL(string: "https://lambdaswapi.herokuapp.com")!
    private lazy var peopleURL = URL(string: "/api/people", relativeTo: baseURL)!
    
    
    func fetchPeople(completion: @escaping (Result<[Person], NetworkError>) -> Void ) {
        URLSession.shared.dataTask(with: peopleURL) { data, _, error in
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
