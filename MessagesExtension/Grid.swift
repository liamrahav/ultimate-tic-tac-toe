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
        battleGrounds = [[BattleGround]]()
        // TODO: - Add proper intiializer using 81 tile urlqueryitems
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
