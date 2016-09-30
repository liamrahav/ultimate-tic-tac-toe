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
    let battleGrounds: [[BattleGround]]
    
    /// This initializer instantiates a `Grid` object filled with 9 `BattleGrounds`, which in turn are each filled with 9 `.empty` `Tile`s
    init() {
        var rows = [[BattleGround]]()
        
        for _ in 0..<3 {
            var column = [BattleGround]()
            for _ in 0..<3 {
                column.append(BattleGround())
            }
            rows.append(column)
        }
        
        battleGrounds = rows
    }
    
    init(queryItems: [URLQueryItem]) {
        battleGrounds = [[BattleGround]]()
        // TODO: - Add proper intiializer using 81 tile urlqueryitems
    }
    
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
