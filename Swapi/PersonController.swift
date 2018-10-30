//
//  PersonController.swift
//  Swapi
//
//  Created by Lambda_School_Loaner_34 on 10/30/18.
//  Copyright © 2018 Frulwinn. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://swapi.co/api/people/")!

class PersonController {
    
    //enums used to protect from user error and also to get values like HTTPMethod. Fixed values like directions or days of week. You can't add an extra day or an extra direction
    private enum HTTPMethod: String {
        case get = "GET" //create
        case put = "PUT" //read
        case post = "POST" // update
        case delete = "DELETE" //delete
    }
    
    func searchForPeople(with searchTerm: String, completion: @escaping ([Person]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //You could do: request.httpMethod = "GET"
        
        //now ready to fetch data
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            //no data found
            if let error = error {
                NSLog ("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            // data found but not what we wanted
            guard let data = data else {
                NSLog("Error fetching data, no data found.")
                completion(nil, NSError())
                return
            }
            
            do {
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase // allows birth_Year to birthYear
                
                let searchResults = try jsonDecoder.decode(PersonSearchResults.self, from: data)
                let people = searchResults.results
                completion(people, nil)
                
            } catch {
                NSLog("unable to decode data into people: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
