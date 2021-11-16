//
//  PersonTableViewCell.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PersonCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!

}
