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

    private func setupTextView() {
        textView = UITextView(frame: .zero)
        view.addSubview(textView)
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 20)
        textView.font = font
        textView.autocorrectionType = .no
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.size.height * 0.09),
            textView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -115),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56)
        ])
    }
    
    private func setupTextField() {
        textField = UITextField(frame: .zero)
        view.addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.boldSystemFont(ofSize: 28)
        textField.font = font
        textField.autocorrectionType = .no
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: attributes)
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 25),
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
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        MainViewController.notes[index].title = textField.text
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        MainViewController.notes[index].title = textField.text
//    }

}
