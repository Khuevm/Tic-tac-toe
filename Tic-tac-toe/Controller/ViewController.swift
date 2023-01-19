//
//  ViewController.swift
//  Tic-tac-toe
//
//  Created by Khue on 18/01/2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var crossScoreLabel: UILabel!
    @IBOutlet weak var noughtScoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable
    private var game = Game()
    private var crossScore = 0
    private var noughtScore = 0

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    // MARK: - Helper
    private func updateTurn() {
        game.changeTurn()
        if game.turn == Turn.Cross {
            turnLabel.text = "X"
            turnLabel.textColor = .systemRed
        } else {
            turnLabel.text = "O"
            turnLabel.textColor = .systemBlue
        }
    }
    
    private func updateScore(){
        if game.turn == Turn.Cross {
            crossScore += 1
            crossScoreLabel.text = "Crosses: \(crossScore)"
        } else {
            noughtScore += 1
            noughtScoreLabel.text = "Noughts: \(noughtScore)"
        }
    }
    
    private func showAlert(title: String?){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Play Again", style: .default) { action in
            self.game = Game()
            self.collectionView.reloadData()
        }
        alert.addAction(action)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.present(alert, animated: true)
        }
    }

}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell
        if currentCell.label.text == "" {
            game.setMove(x: indexPath.section, y: indexPath.row)
            let result = game.checkResult()
            if result == .End {
                updateScore()
                showAlert(title: "\(game.turn) win!!!")
            } else if result == .Draw {
                showAlert(title: "DRAW!!!")
            } else {
                updateTurn()
            }
            collectionView.reloadData()
        }
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return K.gameSize
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.gameSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! GameCollectionViewCell
        let currentItem = game.getBoardLabel(x: indexPath.section, y: indexPath.row)
        cell.updateLabel(turn: currentItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 2*(CGFloat(K.gameSize)-1)) / CGFloat(K.gameSize)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    }
}
