//
//  CoreaDataManager.swift
//  NotesApp
//
//  Created by Kostya Lee on 20/01/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "MyNotes")
    let persistentContainer: NSPersistentContainer
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores {
            (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}
