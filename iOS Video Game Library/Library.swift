//
//  Library.swift
//  iOS Video Game Library
//
//  Created by Sawyer Shirley on 10/30/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation


class Library {
    //Singleton
    static let sharedInstance = Library()
    
    var games = [Game]()

}
