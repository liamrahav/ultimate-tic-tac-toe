//
//  Tile.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/28/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit

/**
 This protocool exists to allow for `QueryItemRepresentable` to work properly with `Tile`, as well as to provide additional properties for `Tile`
 */
protocol TileProtocol {
    /// This variable represents the enum as a `String`
    var rawValue: String { get }
    
    /// This image represents the current ownership of any particular tile
    var image: UIImage { get }
}

extension TileProtocol {
    var image: UIImage {
        let imageName = self.rawValue
        guard let image = UIImage(named: imageName) else { fatalError("Unable to find image named \(imageName)") }
        return image
    }
}

/**
 This enum represents the different states that each indivudal tile within a battleground can have.
 */
enum Tile: String, QueryItemRepresentable, TileProtocol {
    /// The x case refers to when the X player has claimed this tile
    case x
    /// The p case refers to when the O player has claimed this tile
    case o
    /// The empty case refers to when neither player has claimed this tile
    case empty
    
    static let all: [Tile] = [.x, .o, .empty]
    
    static var queryItemKey: String {
        return "Tile"
    }
}

/**
 Extends instances of `QueryItemRepresentable` that also conformt to `IceCreamPart`
 to provide a default implementation of `queryItem`.
 */
extension QueryItemRepresentable where Self: TileProtocol {
    var queryItem: URLQueryItem {
        return URLQueryItem(name: Self.queryItemKey, value: rawValue)
    }
}
