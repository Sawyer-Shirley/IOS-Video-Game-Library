//
//  LibraryCell.swift
//  iOS Video Game Library
//
//  Created by Sawyer Shirley on 11/1/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellGenre: UILabel!
    
    @IBOutlet weak var cellDueDate: UILabel!
    
    @IBOutlet weak var cellRating: UILabel!
    
    @IBOutlet weak var availabilityView: UIView!
    
    
    
    func setup(game: Game) {
        
        cellTitle.text = game.title
        
        switch game.genre {
        case .action:
            cellGenre.text = "Action"
        case .adventure:
            cellGenre.text = "Adventure"
        case .horror:
            cellGenre.text = "Horror"
        case .rpg:
            cellGenre.text = "Role Playing Game"
        case .sandbox:
            cellGenre.text = "Sandbox"
        }
        
        cellRating.text = game.rating.rawValue
        
        switch game.availability {
        case .checkedIn:
            // Hide due date
            cellDueDate.isHidden = true
            //Set view to green
            availabilityView.backgroundColor = .green
            
        case .checkedOut(let date):
            //show due date
            cellDueDate.isHidden = false
            //set view to red
            availabilityView.backgroundColor = .red
            //set dueDate to formatted date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            cellDueDate.text = dateFormatter.string(from: date)
        }
        
    }
    
}
