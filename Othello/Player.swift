//
//  Player.swift
//  Othello
//
//  Created by kaori hirata on 2017-09-12.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import Cocoa

struct Player {

    let chipDictionaly = [ 0: "🍎", 1: " 🐨", 2: " 🐷", 9: "🌴"]
    
    let playerChip : Int
    var playerIcon = ""
    
    init(chip:String) {
        let myChip = Int(chip)
        self.playerChip = myChip!
        self.playerIcon = chipDictionaly[myChip!]!
    }
    
}
