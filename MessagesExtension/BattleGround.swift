//
//  BattleGround.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/28/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import Foundation

/**
 One of the nine small grids in the larger grid. For simplicity, we refer to these small grids as BattleGrounds. Each of these grids contains a 2-D array of `Tile`s, which can be claimed by either player
 
 - note: The `tiles` variable is mutable
 */
public class BattleGround {
    /// This array contains the individual tiles in each battle ground
    var tiles: [[Tile]]
    
    /// This computed property is a 9 count array of type `URLQueryItem` that represents each tile in the battleground
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        for row in tiles {
            for tile in row {
                items.append(tile.queryItem)
            }
        }
        
        return items
    }
    
    /// This computer property stores the winner of the battleground, if there is one
    var winner: Tile? {
        var winner: Tile? = nil
        
        // Accross the top
        if (tiles[0][0] != .empty && tiles[0][0] == tiles[0][1] && tiles[0][0] == tiles[0][2]) { winner = tiles[0][0] }
        // Accross the middle
        else if (tiles[1][0] != .empty && tiles[1][0] == tiles[1][1] && tiles[1][0] == tiles[1][2]) { winner = tiles[1][0] }
        // Across the bottom
        else if  (tiles[2][0] != .empty && tiles[2][0] == tiles[2][1] && tiles[2][0] == tiles[2][2]) { winner = tiles[2][0] }
        
        // Down the left
        else if (tiles[0][0] != .empty && tiles[0][0] == tiles[1][0] && tiles[0][0] == tiles[2][0]) { winner = tiles[0][0] }
        // Down the middle
        else if (tiles[0][1] != .empty && tiles[0][1] == tiles[1][1] && tiles[0][1] == tiles[2][1]) { winner = tiles[0][1] }
        // Down the right
        else if (tiles[0][2] != .empty && tiles[0][2] == tiles[1][2] && tiles[0][2] == tiles[2][2]) { winner = tiles[0][2] }
        
        // Diagonals
        else if (tiles[0][0] != .empty && tiles[0][0] == tiles[1][1] && tiles[0][0] == tiles[2][2]) { winner = tiles[0][0] }
        else if (tiles[0][2] != .empty && tiles[0][2] == tiles[1][1] && tiles[0][2] == tiles[2][0]) { winner = tiles[0][2] }
        
        return winner
    }
    
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
    
    /// This convenience initializer takes an array of queryItems and generates the proper tile array from them.
    ///
    /// - note: The reason why this is a convenience initializer that first calls the default `init()` (creating a blank
    ///         tile grid), and then adds in the appropriate tiles, is that this function is implemented in a way that directly
    ///         accesses the array of tiles (e.g. `tiles[1][2]`)
    ///
    /// - important: The array must be of size 9, or the initializer will not work as intended
    convenience init(queryItems: [URLQueryItem]) {
        self.init()
        
        for i in 0..<queryItems.count {
            let queryItem = queryItems[i]
            guard let value = queryItem.value else { continue }
            
            if let tile = Tile(rawValue: value), queryItem.name == Tile.queryItemKey {
                let row: Int = i / 3
                let column: Int = i % 3
                tiles[row][column] = tile
            } else {
                fatalError("Expected the queryItem to be a Tile")
            }
        }
    }
}
