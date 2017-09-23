//
//  GameManager.swift
//  Othello
//
//  Created by kaori hirata on 2017-09-13.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import Cocoa

class GameManager: NSObject {
    var inputNum = [Int]()
    var actualRowIdx:Int!
    var actualColIdx:Int!
    var fchipExistInd:Int!
    var lchipExistInd:Int!
    var gameOver:Bool = false
    
    
    override init() {
    }
    
    func getNumInput(input:String?)->Void{
        inputNum.removeAll()
        guard let unwrappedInt = input, unwrappedInt != "" else{
            return
        }
        let arrayIndexNumber = unwrappedInt.components(separatedBy: " ") // run when input has value
        inputNum.append(Int(arrayIndexNumber[0])!)
        inputNum.append(Int(arrayIndexNumber[1])!)
    }
    
    func checkMove(board b:Board)->Bool{
        var result = false
        actualRowIdx = Int(inputNum[0])
        actualColIdx = Int(inputNum[1])
        if(b.currentBoard[actualRowIdx][actualColIdx] == 0){
            result = true
        }
        return result
    }

// flip Row section
    func flipChipRow(board b:Board,player p:Player)->Void{
        var recRow = actualRowIdx
        var recCol = actualColIdx
//        print(recCol)
        hasChipInRowRight(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
        hasChipInRowLeft(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
    }
    
    func hasChipInRowRight(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print("Right\(recCol)")
        recCol = recCol + 1 // check from next index
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
//            print(recCol)
            flipChipRowLeft(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInRowRight(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func flipChipRowLeft(board b:Board, player p:Player, recRow: inout Int, recCol: inout Int)->Void{
        recCol = recCol - 1
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){  // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipRowLeft(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func hasChipInRowLeft(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print("Left\(recCol)")
        recCol = recCol - 1 // check from next index
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
//            print(recCol)
            flipChipRowRight(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInRowLeft(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func flipChipRowRight(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void{
        recCol = recCol + 1
//        ("recCol\(recCol) ")
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){  // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipRowRight(board: b, player: p, recRow:&recRow,recCol:&recCol)
        }
    }
    

// flip colm section
    func flipChipCol(board b:Board,player p:Player)->Void{
        var recRow = actualRowIdx
        var recCol = actualColIdx
//        print(recRow)
        hasChipInColUp(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
        hasChipInColdown(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
    }
    
    func flipChipColup(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print(recRow)
        recRow = recRow - 1
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){  // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
//            recRow = recRow - 1
            flipChipColup(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func hasChipInColdown(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print("Down\(recRow)")
        recRow = recRow + 1 // check from next index
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
//            print(recRow)
            flipChipColup(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInColdown(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func hasChipInColUp(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print(recRow)
        recRow = recRow - 1 // check from next index
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
            flipChipColdown(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInColUp(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func flipChipColdown(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
        recRow = recRow + 1
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){ // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipColdown(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    
    
// flip diagonal section
    func flipChipDia(board b:Board,player p:Player)->Void{
        var recRow = actualRowIdx
        var recCol = actualColIdx
        hasChipInDiaRup(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
        hasChipInDiaRdown(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
        hasChipInDiaLup(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
        hasChipInDiaLdown(board:b,player:p,recRow: &recRow!,recCol: &recCol!)
        recRow = actualRowIdx // for back to base position
        recCol = actualColIdx // for back to base position
    }
    
    func hasChipInDiaRup(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print("DiaRU\(recCol)")
        recCol = recCol + 1 // check from next index
        recRow = recRow - 1
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
            print(recCol)
            flipChipDiaLdown(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInDiaRup(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func flipChipDiaLdown(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void{
        print(">>>\(recRow) \(recCol)")
        recRow = recRow + 1
        recCol = recCol - 1
        print("after \(recRow) \(recCol)")
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){ // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipDiaLdown(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func hasChipInDiaRdown(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print("DiaRD Row\(recRow) DiaRD Col\(recCol)")
        recRow = recRow + 1 // check from next index
        recCol = recCol + 1
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
//            print(recCol)
            flipChipDiaLup(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInDiaRdown(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func flipChipDiaLup(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void{
        recRow = recRow - 1
        recCol = recCol - 1
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){ // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipDiaLup(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func hasChipInDiaLup(board b:Board, player p:Player,recRow: inout Int,recCol: inout Int)->Void{
//        print("DiaLU\(recCol)")
        recCol = recCol - 1 // check from next index
        recRow = recRow - 1
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
//            print(recCol)
            flipChipDiaRdown(board:b, player:p,recRow: &recRow,recCol:&recCol)
        }
        else{
            hasChipInDiaLup(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    func flipChipDiaRdown(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void{
        recRow = recRow + 1
        recCol = recCol + 1
        let n = b.currentBoard[recRow][recCol] // flip from found index(exisded index).
        if(n == p.playerChip){ // flip finish if back to selected index
            return
        }else{
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipDiaRdown(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
    }
    
    func hasChipInDiaLdown(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void{
        recRow = recRow + 1
        recCol = recCol - 1
        let n = b.currentBoard[recRow][recCol]
        if(n == 0 || n == 9){
            return
        }
        else if(n == p.playerChip){
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipDiaRup(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }
        else{
            hasChipInDiaLdown(board: b, player: p,recRow:&recRow,recCol:&recCol)
        }

    }
    func flipChipDiaRup(board b:Board,player p:Player,recRow: inout Int,recCol: inout Int)->Void {
        recRow = recRow - 1
        recCol = recCol + 1
        let n = b.currentBoard[recRow][recCol]// flip from found index(exisded index).
        if(n == p.playerChip){ // flip finish if back to selected index
            return
        } else {
            b.currentBoard[recRow][recCol] = p.playerChip
            flipChipDiaRup(board: b, player: p, recRow:&recRow,recCol:&recCol)
        }
    }
    
/// game over section
    func isGameOver(board b:Board,player p:Player)->Bool{
        if(b.iConOneCount == 0 && p.playerChip == 2){
            print("p2 \(p.playerIcon) win")
            gameOver = true
        }
        else if(b.iConTwoCount == 0 && p.playerChip == 1){
            print("p1\(p.playerIcon) win")
            gameOver = true
        }
        else if(b.iConZeroCount == 0){
            gameOver = true
            if(b.iConOneCount == 18 && b.iConTwoCount == 18){
                print("Draw")
            }
            else{
                if(b.iConOneCount > b.iConTwoCount){
                    print("p1 win!!  p1 : \(b.iConOneCount)  p2 : \(b.iConTwoCount)")
                }
                else{
                    print("p2 win!!  p1 : \(b.iConOneCount)  p2 : \(b.iConTwoCount)")
                }
            }
        }
        else{
            gameOver = false
        }
        return gameOver
    }
}
