//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Kostya Lee on 12/01/22.
//

import UIKit

class NoteViewController: UIViewController {
    private var noteId: String!
    private var textView: UITextView!
    private var textField: UITextField!
    private var index: Int!
    var noteCell: NoteCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        index = MainViewController.notes.firstIndex(where: {$0.id == noteId})!
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        setupNavigationBarItem()
        setupTextView()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let note = MainViewController.notes[index]
        textView.text = note.text
        textField.text = note.title
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let noteCell = noteCell else {
            return
        }
        noteCell.prepareNote()
        noteCell.configure(note: MainViewController.notes[index])
        noteCell.configureLabels()
    }
    
    private func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
    }

    private func setupTextView() {
        textView = CustomtextView(frame: .zero)
        view.addSubview(textView)
        textView.delegate = self
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.size.height * 0.09),
            textView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -115),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56)
        ])
    }
    
    private func setupTextField() {
        textField = CustomTextField(frame: .zero)
        view.addSubview(textField)
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -70)
        ])

    }
    
    func set(noteId: String) {
        self.noteId = noteId
    }
    
    func set(noteCell: NoteCell) {
        self.noteCell = noteCell
    }
}

extension NoteViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        MainViewController.notes[index].text = textView.text
        CoreDataManager.shared.save()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        MainViewController.notes[index].title = textField.text!
        CoreDataManager.shared.save()
    }
    
}

extension NoteViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
