//
//  Game.swift
//  Tic-tac-toe
//
//  Created by Khue on 19/01/2023.
//

import Foundation

struct Game {
    var turn = Turn.Cross
    private var board: [[Turn?]]
    private var currentMove = 0
    
    init(){
        let gameRow: [Turn?] = Array(repeating: nil, count: K.gameSize)
        board = Array(repeating: gameRow, count: K.gameSize)
    }
    
    mutating func changeTurn() {
        turn = turn == Turn.Cross ? Turn.Nought : Turn.Cross
    }
    
    mutating func setMove(x: Int, y: Int) {
        board[x][y] = turn
        currentMove += 1
    }
    
    func getBoardLabel(x: Int, y: Int) -> Turn? {
        return board[x][y]
    }
    
    func checkResult() ->  Result? {
        // Check hàng ngang
        for column in 0..<K.gameSize {
            var count = 0
            var lastItem: Turn? = board[column][0]
            for row in 0..<K.gameSize {
                let currentItem = board[column][row]
                if currentItem != nil && currentItem == lastItem {
                    count += 1
                    if count == K.gameMove {
                        return .End
                    }
                } else {
                    count = 1
                }
                lastItem = currentItem
            }
        }
        
        //Check hàng dọc
        for row in 0..<K.gameSize {
            var count = 0
            var lastItem: Turn? = board[0][row]
            for column in 0..<K.gameSize {
                let currentItem = board[column][row]
                if currentItem != nil && currentItem == lastItem {
                    count += 1
                    if count == K.gameMove {
                        return .End
                    }
                } else {
                    count = 1
                }
                lastItem = currentItem
            }
        }
        
        //Check hàng chéo xuống
        for num in 0...K.gameSize-K.gameMove {
            // Theo cột
            var count1 = 0
            var lastItem1: Turn? = board[0][num]
            for i in 0..<K.gameSize-num {
                let currentItem = board[i][num+i]
                if currentItem != nil && currentItem == lastItem1 {
                    count1 += 1
                    if count1 == K.gameMove {
                        return .End
                    }
                } else {
                    count1 = 1
                }
                lastItem1 = currentItem
            }
            
            //Theo hàng
            var count2 = 0
            var lastItem2: Turn? = board[num][0]
            for i in 0..<K.gameSize-num {
                let currentItem = board[num+i][i]
                if currentItem != nil && currentItem == lastItem2 {
                    count2 += 1
                    if count2 == K.gameMove {
                        return .End
                    }
                } else {
                    count2 = 1
                }
                lastItem2 = currentItem
            }
        }
        
        
        //Check hàng chéo lên
        for num in K.gameMove-1..<K.gameSize {
            // Theo cột
            var count1 = 0
            var lastItem1: Turn? = board[0][num]
            for i in 0...num {
                let currentItem = board[i][num-i]
                if currentItem != nil && currentItem == lastItem1 {
                    count1 += 1
                    if count1 == K.gameMove {
                        return .End
                    }
                } else {
                    count1 = 1
                }
                lastItem1 = currentItem
            }
            
            //Theo hàng
            var count2 = 0
            var lastItem2: Turn? = board[K.gameSize-num-1][K.gameSize-1]
            for i in 0...num {
                let currentItem = board[K.gameSize-num+i-1][K.gameSize-i-1]
                if currentItem != nil && currentItem == lastItem2 {
                    count2 += 1
                    if count2 == K.gameMove {
                        return .End
                    }
                } else {
                    count2 = 1
                }
                lastItem2 = currentItem
            }
        }
        
        //Check hoà
        if currentMove == K.gameMove*K.gameMove {
            return .Draw
        }
        
        return nil
    }
}
