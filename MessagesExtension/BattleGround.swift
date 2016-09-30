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
    
    /// This initializer takes an array of queryItems and generates the proper tile array from them
    ///
    /// - important: The array must be of size 9, or the initializer will not work as intended
    init(queryItems: [URLQueryItem]) {
        tiles = [[Tile]]()
        
        for i in 0..<queryItems.count {
            let queryItem = queryItems[i]
            guard let value = queryItem.value else { continue }
            
            if let tile = Tile(rawValue: value), queryItem.name == Tile.queryItemKey {
                let row = i / 3
                let column = i % 3
                tiles[row][column] = tile
            }
        }
    }
}
