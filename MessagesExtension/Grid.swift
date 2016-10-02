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
    
    /// This computed property is an 81 count array of all tiles in the grid
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
                // Adds 3 battlegrounds to each row
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
