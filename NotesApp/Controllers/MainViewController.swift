//
//  ViewController.swift
//  NotesApp
//
//  Created by Kostya Lee on 12/01/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var searchedNotes = [Note]()
    static var notes = [Note]()
    
    var searchController = UISearchController(searchResultsController: nil)
        
    var tableView: UITableView?
    let label = UILabel()
    let button = AddButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        
        setupNavigationController()
        setupTableView()
        setupButton()
        setupLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeCellIfEmpty()
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.setButtonConstraints(view: view)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        let dateComponentsNow = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: .now)
        let newNote = Note(title: "", text: "", id: UUID().uuidString, dateComponents: dateComponentsNow)
        MainViewController.notes.insert(newNote, at: 0)
        
        tableView!.beginUpdates()
        tableView!.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView!.endUpdates()
        
        let noteVC = NoteViewController()
        noteVC.noteCell = nil
        noteVC.set(noteId: newNote.id)
        noteVC.set(noteCell: (tableView?.cellForRow(at: IndexPath(row: 0, section: 0) ) as! NoteCell))
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.text = "No notes yet"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationController() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        search(text: text)
    }
    
    func search(text: String) {
        searchedNotes = MainViewController.notes.filter {
            $0.text.lowercased().contains(text.lowercased()) || $0.title.lowercased().contains(text.lowercased())
        }
        tableView?.reloadData()
    }
}
