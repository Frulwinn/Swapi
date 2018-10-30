//
//  PersonSearchTableViewController.swift
//  Swapi
//
//  Created by Lambda_School_Loaner_34 on 10/30/18.
//  Copyright © 2018 Frulwinn. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    let personController = PersonController()
    
    var people = [Person](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return}
            
            personController.searchForPeople(with: searchTerm) {(people, error) in
                self.people = people ?? []
            }
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starwarsCell", for: indexPath) as! PersonTableViewCell

        let person = people[indexPath.row]
        cell.nameLabel.text = person.name
        cell.genderLabel.text = person.gender
        cell.birthLabel.text = person.birthYear

        return cell
    }


}
