//
//  GameCollectionViewCell.swift
//  Tic-tac-toe
//
//  Created by Khue on 18/01/2023.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    func updateLabel(turn: Turn?) {
        if turn == .Cross {
            label.text = "X"
            label.textColor = .systemRed
        } else if turn == .Nought {
            label.text = "O"
            label.textColor = .systemBlue
        } else {
            label.text = ""
        }
    }
}
