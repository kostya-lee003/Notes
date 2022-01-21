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
    var dateLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        textLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        detailTextLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        setupDateLabel()
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
    
    private func setupDateLabel() {
        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 74, height: 50))
        dateLabel.textAlignment = .right
        accessoryView = dateLabel

        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 14)
    }
        
    func configureLabels() {
        self.textLabel?.text = note?.title ?? ""
        self.detailTextLabel?.text = note?.text ?? ""
        
//        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: .now)
//        let dateNow = Calendar.current.date(from: components)
        
        
//        if Date.isToday(day: self.dateComponentsNow.day!) {
//            dateLabel.text = "\(dateComponentsNow.hour!):\(dateComponentsNow.minute!)"
//        } else if Date.isThisYear(year: self.dateComponentsNow.year!) {
//            dateLabel.text = "\(dateComponentsNow.day!).\(dateComponentsNow.month!)"
//        } else {
//            dateLabel.text = "\(dateComponentsNow.day!).\(dateComponentsNow.month!).\(dateComponentsNow.year!)"
//        }
        
        guard let note = note else {
            print("Found nil value in variable note")
            return
        }
        let formatter = DateFormatter()
        if Date.isToday(day: note.date.get(.day)) {
            formatter.dateFormat = "HH:mm"
        } else if Date.isThisYear(year: note.date.get(.year)) {
            formatter.dateFormat = "MMM d"
        } else {
            formatter.dateFormat = "MM/dd/yyyy"
        }
        dateLabel.text = formatter.string(from: note.date)
    }
    
    func configure(note: Note) {
        self.note = note
    }
    
    func prepareNote() {
        self.note = nil
    }
}

