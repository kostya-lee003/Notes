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
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
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
    
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.self.title = ""
        note.text = ""
        note.id = UUID().uuidString
        note.date = Date()
        save()
        return note
    }
    
    // Saving notes to database
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error occured while saving data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNotes(filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        // filtering notes
        if let filter = filter {
            let pr1 = NSPredicate(format: "title contains[cd] %@", filter)
            let pr2 = NSPredicate(format: "text contains[cd] %@", filter)
            let predicate = NSCompoundPredicate(type: .or, subpredicates: [pr1, pr2])
            request.predicate = predicate
        }
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
