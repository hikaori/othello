//
//  Board.swift
//  Othello
//
//  Created by kaori hirata on 2017-09-12.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import Cocoa

class Board: CustomStringConvertible {
    
    let chipDictionaly = [ 0: "🍎", 1: " 🐨", 2: " 🐷", 9: "🌴"]
    
    
    var currentBoard:[[Int]]
    var rowCount: Int {
        get {return currentBoard.count - 1}
    }
    var colCount: Int{
        get{return currentBoard[0].count - 1}
    }
    var iConZeroCount: Int = 0
    var iConOneCount : Int = 0
    var iConTwoCount: Int = 0
    var iConNineCount: Int = 0
    
    
    init() {
        self.currentBoard =
                    [[9,9,9,9,9,9,9,9,9,9],
                     [9,0,0,0,0,0,0,0,0,9],
                     [9,0,0,0,0,0,0,0,0,9],
                     [9,0,0,0,0,0,0,0,0,9],
                     [9,0,0,0,1,2,0,0,0,9],
                     [9,0,0,0,2,1,0,0,0,9],
                     [9,0,0,0,0,0,0,0,0,9],
                     [9,0,0,0,0,0,0,0,0,9],
                     [9,0,0,0,0,0,0,0,0,9],
                     [9,9,9,9,9,9,9,9,9,9],

        ]
    }
    
    public var description: String {
        return "Board: \(currentBoard)"
    }
    
    func displayBoard(board:Board)->Void{
        var line = 0
        
        iConZeroCount = 0
        iConOneCount  = 0
        iConTwoCount = 0
        iConNineCount = 0
        
        print("--------------------------------------------------------------------------")
        for _ in 0...rowCount{
            for num in self.currentBoard[line] {  // create one row
                let iconNum = chipDictionaly[num]
                print("| \(iconNum!) | ", terminator: "")
                countIcon(icon:num)
            }
            print("")
            print("--------------------------------------------------------------------------")
            line += 1
        }
    }
    
    func countIcon(icon:Int){
        switch icon {
        case 0:
            iConZeroCount = iConZeroCount + 1
        case 1:
            iConOneCount  = iConOneCount  + 1
        case 2:
            iConTwoCount = iConTwoCount + 1
        case 9:
            iConNineCount = iConNineCount + 1
        default:
            iConZeroCount = iConZeroCount + 0
        }
    }
}
