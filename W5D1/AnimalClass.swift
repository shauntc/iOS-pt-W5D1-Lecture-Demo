//
//  AnimalClass.swift
//  W5D1
//
//  Created by uForis VR on 2018-03-26.
//  Copyright © 2018 shauntc. All rights reserved.
//

import Foundation
import Parse

class AnimalClass : PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "AnimalClass"
    }
    @NSManaged var animalType:String
    @NSManaged var animalMood:String
    
    //////// End of Lecture content //////////

    
    convenience init(type: String, mood: String) {
        self.init()
        self.animalType = type
        self.animalMood = mood
    }
    static let AnimalTypeKey = "animalType"
    static let AnimalMoodKey = "animalMood"
    static let Happy = "Happy"
    static let Sad = "Sad"
    static let Mischievous = "Mischievous"
}
