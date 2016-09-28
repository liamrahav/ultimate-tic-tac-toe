//
//  MSMessageTemplateLayout+Initializer.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/28/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit
import Messages

/**
 This extension provides a convenience initializer to make creating `MSMessage`s simpler
 */
extension MSMessageTemplateLayout {
    /// This initializer takes in an image and a caption and returns a properly set `MSMessageTemplateLayout`
    ///
    /// - Note: This convenience initializer is declared in an extension.
    convenience init(image: UIImage, caption: String) {
        self.init()
        self.image = image
        self.caption = caption
    }
}
