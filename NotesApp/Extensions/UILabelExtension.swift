//
//  UILabelExtension.swift
//  NotesApp
//
//  Created by Kostya Lee on 29/05/24.
//

import Foundation
import UIKit
extension UILabel {
    func animateIn() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
        self.alpha = 1.0
        }, completion: nil)
    }
    
    func animateOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
