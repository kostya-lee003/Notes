//
//  ResultsViewController.swift
//  NotesApp
//
//  Created by Kostya Lee on 17/01/22.
//

import UIKit

class ResultsViewController: UITableViewController {
    var searchedNotes: [Note]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.id)
    }
    
    func search(text: String) {
        searchedNotes = MainViewController.notes.filter {
            $0.text.lowercased().contains(text.lowercased()) || $0.title.lowercased().contains(text.lowercased())
        }
        tableView.reloadData()
    }
}

extension ResultsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected searched note")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.id, for: indexPath) as! NoteCell
        cell.configure(note: searchedNotes![indexPath.row])
        cell.configureLabels()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedNotes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 85 }
}
