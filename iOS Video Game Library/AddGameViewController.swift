//
//  AddGameViewController.swift
//  iOS Video Game Library
//
//  Created by Sawyer Shirley on 10/31/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ratingControl: UISegmentedControl!
    @IBOutlet weak var genreControl: UIPickerView!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBAction func saveTapped(_ sender: Any) {
        trySavingGame()
    }
    
    
    
    //Shows options for rating
    let segments: [(title: String, rating: Game.Rating)] =
        [("E", .everyone),
         ("T", .teen),
         ("M", .mature),
         ("AO", .adultsOnly)]
    
    //Shows genre options
    let genres: [(title: String, genre: Game.Genre)] =
        [("Action", .action),
         ("Sandbox", .sandbox),
         ("Adventure", .adventure),
         ("Horror", .horror),
         ("Role Playing Game", .rpg)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        ratingControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            ratingControl.insertSegment(withTitle: segment.title, at: index, animated: false)
        }
        
        genreControl.dataSource = self
        genreControl.delegate = self
        
        ratingControl.selectedSegmentIndex = 0;
        
    }
    
    
    func trySavingGame() {
        
        // title
        guard let title = titleTextField.text else { return }
        
        // details
        guard let details = descriptionText.text else { return }
        
        // rating
        let rating = segments[ratingControl.selectedSegmentIndex].rating
        
        // genre
        let genre = genres[genreControl.selectedRow(inComponent: 0)].genre
        
        let game = Game(title: title, detail: details, rating: rating, genre: genre)
        
        //Adds new game to the game array
        Library.sharedInstance.games.append(game)
       self.navigationController?.popViewController(animated: true)
    }

}




extension AddGameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row].title
    }
}
