//
//  Person.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import Foundation

struct People: Codable{
    let results: [Person]
}

struct Person: Codable {
    
    enum PersonKeys: String, CodingKey {
    case name
    case birthYear = "birth_year"
    case height
    }
    
    let name: String
    let birthYear: String
    let height: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonKeys.self)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(String.self, forKey: .height)
        birthYear = try container.decode(String.self, forKey: .birthYear)
    }
}
