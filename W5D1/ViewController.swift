//
//  ViewController.swift
//  W5D1
//
//  Created by uForis VR on 2018-03-26.
//  Copyright © 2018 shauntc. All rights reserved.
//

import UIKit
import Parse


class ViewController: UITableViewController, UINavigationControllerDelegate {
    
    var animals = [AnimalClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    func reloadData() { // This reloads the data from Parse server
        let query = AnimalClass.query()
        query?.whereKeyExists(AnimalClass.AnimalMoodKey)
        query?.findObjectsInBackground(block: { (objects, error) -> Void in
            if let objects = objects as? [AnimalClass] {
                
                // Sort the data by the date it was created
                self.animals = objects.sorted(by: { (first, second) -> Bool in
                    if let firstDate = first.createdAt, let secondDate = second.createdAt {
                        return firstDate < secondDate
                    }
                    return true
                })
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as? TableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)
        }
        
        let animal = self.animals[indexPath.row]
        
        cell.textLabel?.text = "\(animal.animalType) that is \(animal.animalMood)"
        
        guard let emoji = ViewController.Emojis[animal.animalType]?[animal.animalMood] else {
            return cell
        }
        cell.emojiBox.text = emoji
        
        return cell;
    }
    
    /////////////// /////////////// /////////////// /////////////// END OF CODE FROM CLASS /////////////// /////////////// /////////////// ///////////////
    
    // This adds a random Animal
    @IBAction func addButtonPressed(_ sender: Any) {
        let type = arc4random_uniform(2)
        let mood = arc4random_uniform(3)
        var moodString = ""
        switch mood {
        case 0:
            moodString = AnimalClass.Happy
        case 1:
            moodString = AnimalClass.Sad
        case 2:
            moodString = AnimalClass.Mischievous
        default:
            moodString = "Unknown"
        }
        
        var typeString = ""
        switch type {
        case 0:
            typeString = "Cat"
        case 1:
            typeString = "Dog"
        default:
            typeString = "Unknown"
        }
        
        let animal = AnimalClass(type: typeString, mood: moodString)
        animal.saveInBackground(block: { (success, error) in
            self.reloadData()
        })
        
        let alert = UIAlertController(title: "Created Animal", message: "Created a \(moodString) \(typeString)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // This allows us to delete items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            animals[indexPath.row].deleteInBackground(block: { (success, error) in
                if(success) {
                    DispatchQueue.main.async {
                        self.reloadData();
                    }
                } else {
                    let alert = UIAlertController(title: "Failed to delete", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    

    
    static let Emojis = [
        "Cat":[
            AnimalClass.Happy: "😺",
            AnimalClass.Sad: "😾",
            AnimalClass.Mischievous: "😼"
        ],
        "Dog": [
            AnimalClass.Happy: "🐶",
            AnimalClass.Sad: "🐕",
            AnimalClass.Mischievous: "🐩"
        ]
    ]
}

