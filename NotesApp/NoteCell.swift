//
//  NoteCell.swift
//  NotesApp
//
//  Created by Kostya Lee on 12/01/22.
//

import UIKit

class NoteCell: UITableViewCell {
    
    static let id = "NoteCell"
    private var note: Note?
    private var titleLabel: UILabel!
    private var customTextLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        textLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        
        detailTextLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 74, height: 50))
        accessoryView = label
        label.text = "22.02.2022"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
        
    func configureLabels() {
        self.textLabel?.text = note?.title ?? ""
        self.detailTextLabel?.text = note?.text ?? ""
    }
    
    func configure(note: Note) {
        self.note = note
    }
    
    func prepareNote() {
        self.note = nil
    }
}

