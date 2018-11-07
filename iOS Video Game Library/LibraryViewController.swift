//
//  LibraryViewController.swift
//  iOS Video Game Library
//
//  Created by Sawyer Shirley on 10/30/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let library = Library.sharedInstance
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        //Adding some basic games
            library.games.append(Game(title: "Minecraft", detail: "Minecraft is a 2011 sandbox video game created by Swedish game developer Markus Persson and later developed by Mojang. The game allows players to build with a variety of different blocks in a 3D procedurally generated world, requiring creativity from players. Other activities in the game include exploration, resource gathering, crafting, and combat.", rating: .everyone, genre: .sandbox) )
            library.games.append(Game(title: "Overwatch", detail: "Overwatch is a team-based multiplayer first-person shooter video game developed and published by Blizzard Entertainment, which released on May 24, 2016 for PlayStation 4, Xbox One, and Windows. Described as a 'hero shooter', Overwatch assigns players into two teams of six, with each player selecting from a roster of over 20 characters, known as 'heroes', each with a unique style of play whose roles are divided into three general categories that fit their role. Players on a team work together to secure and defend control points on a map or escort a payload across the map in a limited amount of time.", rating: .teen, genre: .action) )

        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        // A little trick for removing the cell separators
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    //Transfering game info from library screen to Game Info screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowGameInfo" {

               let indexPath = self.tableView!.indexPathsForSelectedRows!.first!
                let game = library.games[indexPath.row]
                let vc = segue.destination as! GameInfoViewController
                vc.details = game.detail
                vc.text = game.title
                vc.genre = game.genre.rawValue
                vc.rating = game.rating.rawValue

            }
   }
}





//Creates table view
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    //Creating a new cell based on info added in CreateGame area
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LibraryCell
        
        let game = library.games[indexPath.row]
        cell.setup(game: game)
        
        return cell
    }
    
    //Checking out a game
    func checkOut(at indexPath: IndexPath) {
    let game = self.library.games[indexPath.row]
    
    let calendar = Calendar(identifier: .gregorian)
    let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
    
    game.availability = .checkedOut(dueDate: dueDate)
    (tableView.cellForRow(at: indexPath) as! LibraryCell).setup(game: game)
    }
    
    //Checking in a game
    func checkIn(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        game.availability = .checkedIn
        (tableView.cellForRow(at: indexPath) as! LibraryCell).setup(game: game)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Deleting Games
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let game = library.games[indexPath.row]
        
        //Adding the ability to swipe left on a cell to check it in and out or delete it
        switch game.availability {
            case .checkedIn:
                let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
            
            self.checkOut(at: indexPath)
            
        }
        
        return [deleteAction, checkOutAction]
        
            case .checkedOut:
                let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
            self.checkIn(at: indexPath)
        }
        
        return [deleteAction, checkInAction]
        
        }
    }
}





    //Shows a special screen when there are no cells with games
extension LibraryViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
  //Creates title for empty library screen
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "You have no games!"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor(red:0.74, green:0.93, blue:0.42, alpha:1.0)]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    //Gives user more information
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "You need to add games to your library."
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    //Labels button for the empty screen
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView?, for state: UIControl.State) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
        
        return NSAttributedString(string: "Add Game", attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView?) -> UIColor? {
        return UIColor(red:0.36, green:0.37, blue:0.61, alpha:1.0)
    }
    
    //Sends user to add a new game when the button on empty library is pressed
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        performSegue(withIdentifier: "addNewGame", sender: self)
    }
}
   
