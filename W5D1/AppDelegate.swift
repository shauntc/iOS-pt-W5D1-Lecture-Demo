//
//  AppDelegate.swift
//  W5D1
//
//  Created by uForis VR on 2018-03-26.
//  Copyright © 2018 shauntc. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = AppKeys.AppId
            ParseMutableClientConfiguration.clientKey = AppKeys.Master
            ParseMutableClientConfiguration.server = AppKeys.Address
        })
        
        Parse.initialize(with:parseConfiguration)        
        AnimalClass.registerSubclass()
        Animal.registerSubclass()
        
//        let myAnimal = AnimalClass(type: "Cat", mood: AnimalClass.Happy)
//        let mySecondAnimal = AnimalClass(type: "Dog", mood: AnimalClass.Happy)
//        let myThirdAnimal = AnimalClass(type: "Cat", mood: "Mischievous")
//        
//        do {
//            try myAnimal.save()
//            try mySecondAnimal.save()
//            try myThirdAnimal.save()
//        } catch {
//            print("Error saving the animals")
//        }
        return true
    }
}

