//
//  PersonSearchTableViewController.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var personController = PersonController()
    var people: [Person]?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell

        if let people = self.people {
            
            let person = people[indexPath.row]
            // Configure the cell...
            cell.nameLabel.text = person.name
            cell.heightLabel.text = "\(person.height) cm"
            cell.birthYearLabel.text = "Born \(person.birthYear)"
        }
        
        return cell
    }

//MARK: - Private Helper Methods
    private func processData(result: Result<[Person], NetworkError>) {
        switch result {
        case .success(let people):
            self.people = people
        case .failure(let error):
            print(error)
        }
    }
    
}

extension PersonSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else {
            print("No search term found.")
            return
        }
        personController.fetchPerson(withTerm: searchTerm) { result in
            self.processData(result: result)
        }
    }
}
