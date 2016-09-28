//
//  BattleGround.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/28/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import Foundation

/**
 One of the nine small grids in the larger grid. For simplicity, we refer to these small grids as `BattleGround`s. Each of these grids contains a 2-D array of `Tile`s, which can be claimed by either player
 
 - Note: The `tiles` variable is mutable
 */
public class BattleGround {
    var tiles: [[Tile]]
    
    /// This initializer creates a `BattleGround` filled with `.empty` tiles
    init() {
        var rows = [[Tile]]()
        
        for _ in 0..<3 {
            var column = [Tile]()
            for _ in 0..<3 {
                column.append(.empty)
            }
            rows.append(column)
        }
        
        tiles = rows
    }
}
