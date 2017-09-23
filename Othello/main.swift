//
//  main.swift
//  Othello
//
//  Created by kaori hirata on 2017-09-12.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import Foundation

print("==== OTHELLO GAME =======")
print("1 - person vs person")
print("2 - person vs computer")
print("enter your choice ")
let input = readLine()

// creat player
print("select your chip  ((  1 🐨  2 🐷 ")
let inputChip = readLine()
var playerChip = ""
if let unwrappedInputChip = inputChip{
    playerChip = unwrappedInputChip
}else{print("No select your chip")}

var p1 = Player(chip: playerChip)
print("p1's icon is \(p1.playerIcon)")
func createOpponentIcon(p1:Player)->String{
    switch p1.playerChip {
    case 1:
        return "2"
    case 2:
        return "1"
    default:
        return ""
    }
}
var opponentIcon:String! = createOpponentIcon(p1: p1)
var p2 = Player(chip: opponentIcon)
print("p2's icon is \(p2.playerIcon)")

//
func makeRandomNum()->String{
    let randomRow = Int(arc4random_uniform(8) + 1) // randome number from 1 to 8
    let randomCol = Int(arc4random_uniform(8) + 1) // randome number from 1 to 8
    let input = "\(randomRow) \(randomCol)"
    return input
}

// creat board
var b = Board.init()
b.displayBoard(board: b)

// creat GameManager
var gm = GameManager.init()


func move(gameManager gm:GameManager,board b:Board, player p: Player){
    print("\(p.playerIcon) make your move. input ex)1 2")
    let input = readLine()
    
    if(gm.getNumInput(input:input) == nil){
        print("empty")
    }
}



func flipChip(gameManager gm:GameManager,board b: Board, player p: Player){
//    print("row:\(gm.actualRowIdx) low:\(gm.actualColIdx) p\(p.playerChip)")
    
//     put and flip in row
    b.currentBoard[gm.actualRowIdx][gm.actualColIdx] = p.playerChip
    
    // flip in row
    gm.flipChipRow(board: b, player: p)
    
    // flip in col
    gm.flipChipCol(board: b, player: p)

    //flip in diagonal
    gm.flipChipDia(board: b, player: p)
    
    b.displayBoard(board: b)
    
}



// game start
switch input!{
case "1":
    print("you selected person vs person")
    while(gm.gameOver == false){
        // movement p1
        move(gameManager: gm, board: b, player: p1)
        while(gm.checkMove(board: b) == false){
            print("can not put storn")
            move(gameManager: gm, board: b, player: p1)
        }
        flipChip(gameManager: gm,board: b, player: p1)
        if(gm.isGameOver(board: b, player: p1)){
            break
        }
        
        // movement p2
        move(gameManager: gm, board: b, player: p2)
        while(gm.checkMove(board: b) == false){
            print("can not put storn")
            move(gameManager: gm, board: b, player: p2)
        }
        flipChip(gameManager: gm,board: b, player: p2)
        if(gm.isGameOver(board: b, player: p2)){
            break
        }
    }
case "2":
    print("you selected person vs computer")
    while(gm.gameOver == false){
        // movement p1
        move(gameManager: gm, board: b, player: p1)
        while(gm.checkMove(board: b) == false){
            print("can not put storn")
            move(gameManager: gm, board: b, player: p1)
        }
        flipChip(gameManager: gm,board: b, player: p1)
            if(gm.isGameOver(board: b, player: p1)){
                break
            }
        
        // movement computer
//        let randomRow = Int(arc4random_uniform(6) + 1) // randome number from 1 to 6
//        let randomCol = Int(arc4random_uniform(6) + 1) // randome number from 1 to 6
//        var input = "\(randomRow) \(randomCol)"
        
        gm.getNumInput(input: makeRandomNum())
        while(gm.checkMove(board: b) == false){
            print("can not put storn")
            gm.getNumInput(input: makeRandomNum())
        }
        flipChip(gameManager: gm,board: b, player: p2)
        if(gm.isGameOver(board: b, player: p2)){
            break
        }
    }
default:
    print("selected defalt")
}














