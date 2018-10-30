//
//  Person.swift
//  Swapi
//
//  Created by Lambda_School_Loaner_34 on 10/30/18.
//  Copyright © 2018 Frulwinn. All rights reserved.
//

import Foundation

struct Person: Codable {
    var name: String
    var gender: String
    var birthYear: String
}

struct PersonSearchResults: Codable {
    var results: [Person]
}

