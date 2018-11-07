//
//  Game.swift
//  iOS Video Game Library
//
//  Created by Sawyer Shirley on 10/30/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation

class Game {
    
    //Ratings
    enum Rating: String {
        case teen = " T "
        case everyone = " E "
        case mature = " M "
        case adultsOnly = " AO "
    }
    
    //Genres
    enum Genre: String {
        case action = "Action"
        case sandbox = "Sandbox"
        case adventure = "Adventure"
        case horror = "Horror"
        case rpg = "RPG"
    }
    
    //Marks if the game is availble or not
    enum Availbility {
        case checkedIn
        //Adds due date if game is checked out
        case checkedOut(dueDate: Date)
    }
    
    
    //Properties
    let title: String
    let detail: String
    let rating: Rating
    let genre: Genre
    var availability: Availbility
    
    init(title: String, detail: String, rating: Rating, genre: Genre) {
        self.title = title
        self.detail = detail
        self.rating = rating
        self.genre = genre
        self.availability = .checkedIn
    }
}
