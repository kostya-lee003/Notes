//
//  TableViewManager.swift
//  NotesApp
//
//  Created by Kostya Lee on 19/01/22.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isSearching: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    internal func setupTableView() {
        let tableView = UITableView(frame: .zero)
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.separatorColor = .systemGray3
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedNotes.count
        } else {
            MainViewController.notes.count == 0 ? label.animateIn() : label.animateOut()
            return MainViewController.notes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.id, for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        if isSearching {
            cell.configure(note: searchedNotes[indexPath.row])
        } else {
            cell.configure(note: MainViewController.notes[indexPath.row])
        }
        cell.dateComponentsNow = MainViewController.notes[indexPath.row].dateComponents
        cell.configureLabels()
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController()
        if isSearching {
            noteVC.set(noteId: searchedNotes[indexPath.row].id)
        } else {
            noteVC.set(noteId: MainViewController.notes[indexPath.row].id)
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteCell else {
            return
        }
        noteVC.set(noteCell: cell)
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 85 }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        removeCell(row: indexPath.row, tableView: tableView)
    }
    
    internal func removeCell(row: Int, tableView: UITableView) {
        MainViewController.notes.remove(at: row)
        let path = IndexPath(row: row, section: 0)
        tableView.deleteRows(at: [path], with: .top)
    }
    
    internal func removeCellIfEmpty() {
        guard let firstNoteCell = MainViewController.notes.first else {
            return
        }
        if firstNoteCell.title.trimmingCharacters(in: .whitespaces).isEmpty &&
            firstNoteCell.text.trimmingCharacters(in: .whitespaces).isEmpty {
            removeCell(row: 0, tableView: tableView!)
        }
    }
    
}
