//
//  MSMessage+CreateMessage.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 10/5/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit
import Messages

extension MSMessage {
    convenience init(grid: Grid, caption: String, session: MSSession? = nil) {
        self.init(session: session ?? MSSession())
        
        var components = URLComponents()
        components.queryItems = grid.queryItems
        
        let image = UIImage(named: "temp")!
        let messageLayout = MSMessageTemplateLayout(image: image, caption: caption)
        
        url = components.url
        print(url)
        layout = messageLayout
    }
}
