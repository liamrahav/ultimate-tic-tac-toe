//
//  Tile.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/28/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import Foundation

/**
 This enum represents the different states that each indivudal tile within a battleground can have.
 */
enum Tile {
    /// The x case refers to when the X player has claimed this tile
    case x
    /// The p case refers to when the O player has claimed this tile
    case o
    /// The empty case refers to when neither player has claimed this tile
    case empty
}
