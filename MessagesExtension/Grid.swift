//
//  Grid.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/28/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit
import Messages

/**
 This class refers to the main game grid. It contains a 2-D array of smaller grids, called `BattleGround`s
 
 - note: The `battleGrounds` array is not mutable. This is because each `BattleGround` is unique and does not need to change.
 */
public class Grid {
    /// This array contains the 9 `BattleGround` objects in which the players can place their X's and O's.
    let battleGrounds: [[BattleGround]]
    
    /// This computed property calculates which player's turn it is based on the total count of X's and O's in the game.
    var currentPlayer: Tile {
        var xCount = 0
        var oCount = 0
        
        for row in battleGrounds {
            for battleGround in row {
                for tileRow in battleGround.tiles {
                    for tile in tileRow {
                        if tile == .x { xCount += 1 }
                        else if tile == .o {oCount += 1 }
                    }
                }
            }
        }
        
        if (xCount == oCount) { return .x }
        return .o
    }
        
    /// This computed property is an 81 count array of all battleGrounds in the grid
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        for row in battleGrounds {
            for battleGround in row {
                for item in battleGround.queryItems {
                    items.append(item)
                }
            }
        }
        
        return items
    }
    
    /// This computer property stores the winner of the game, if there is one
    var winner: Tile? {
        var winner: Tile? = nil
        
        // Accross the top
        if (battleGrounds[0][0].winner != nil && battleGrounds[0][0].winner == battleGrounds[0][1].winner && battleGrounds[0][0].winner == battleGrounds[0][2].winner) { winner = battleGrounds[0][0].winner }
        // Accross the middle
        else if (battleGrounds[1][0].winner != .empty && battleGrounds[1][0].winner == battleGrounds[1][1].winner && battleGrounds[1][0].winner == battleGrounds[1][2].winner) { winner = battleGrounds[1][0].winner }
        // Across the bottom
        else if  (battleGrounds[2][0].winner != .empty && battleGrounds[2][0].winner == battleGrounds[2][1].winner && battleGrounds[2][0].winner == battleGrounds[2][2].winner) { winner = battleGrounds[2][0].winner }
            
        // Down the left
        else if (battleGrounds[0][0].winner != .empty && battleGrounds[0][0].winner == battleGrounds[1][0].winner && battleGrounds[0][0].winner == battleGrounds[2][0].winner) { winner = battleGrounds[0][0].winner }
        // Down the middle
        else if (battleGrounds[0][1].winner != .empty && battleGrounds[0][1].winner == battleGrounds[1][1].winner && battleGrounds[0][1].winner == battleGrounds[2][1].winner) { winner = battleGrounds[0][1].winner }
        // Down the right
        else if (battleGrounds[0][2].winner != .empty && battleGrounds[0][2].winner == battleGrounds[1][2].winner && battleGrounds[0][2].winner == battleGrounds[2][2].winner) { winner = battleGrounds[0][2].winner }
            
        // Diagonals
        else if (battleGrounds[0][0].winner != .empty && battleGrounds[0][0].winner == battleGrounds[1][1].winner && battleGrounds[0][0].winner == battleGrounds[2][2].winner) { winner = battleGrounds[0][0].winner }
        else if (battleGrounds[0][2].winner != .empty && battleGrounds[0][2].winner == battleGrounds[1][1].winner && battleGrounds[0][2].winner == battleGrounds[2][0].winner) { winner = battleGrounds[0][2].winner }
        
        return winner
    }
    
    /// This initializer creates a fresh game with 9 empty battleGrounds
    init() {
        var battleGrounds = [[BattleGround]]()
        
        for _ in 0..<3 {
            var column = [BattleGround]()
            for _ in 0..<3 {
                column.append(BattleGround())
            }
            battleGrounds.append(column)
        }
        
        self.battleGrounds = battleGrounds
    }
    
    /// This initializer takes an array of 81 `Tile` objects represented as `URLQueryItem` objects, and builds the `battleGrounds` array using them.
    init(queryItems: [URLQueryItem]) {
        var battleGrounds = [[BattleGround]]()

        var index: Int = 0
        // Outermost loop that represents each row of the grid
        for _ in 0..<3 {
            var row = [BattleGround]()
            // Second loop that represents each column of the grid
            for _ in 0..<3 {
                var battleGroundItems = [URLQueryItem]()
                // Inner loop that parses through 9 query items to create the proper array for the BattleGround constructor
                for _ in 0..<9 {
                    battleGroundItems.append(queryItems[index])
                    index += 1
                }
                // Adds 3 battleGrounds to each row
                row.append(BattleGround(queryItems: battleGroundItems))
            }
            
            battleGrounds.append(row)
        }
        
        self.battleGrounds = battleGrounds
    }
    
    /// This convenience initializer, taken from Apple's sample Ice Cream Builder app, extracts the `URLQueryItem` array out of a `MSMessage` object.
    convenience init?(message: MSMessage?) {
        guard let messageURL = message?.url else {
            return nil
        }
        
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems else {
                return nil
        }
        
        self.init(queryItems: queryItems)

    }
}
