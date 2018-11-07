//
//  GameInfoViewController.swift
//  iOS Video Game Library
//
//  Created by Sawyer Shirley on 11/5/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {

    
    @IBOutlet weak var gameDescription: UITextView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    @IBOutlet weak var gameGenreLabel: UILabel!
    
    
    var details = String()
    var rating = String()
    var genre = String()
    var text = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameTitleLabel.text = text
        gameDescription.text = details
        gameRatingLabel.text = rating
        gameGenreLabel.text = genre
    }
}
