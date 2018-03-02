//
//  CoreData.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/9/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    static let instance = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherShine")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
