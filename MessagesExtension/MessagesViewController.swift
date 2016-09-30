//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Liam Rahav on 9/21/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit
import Messages
import SnapKit

class MessagesViewController: MSMessagesAppViewController {
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else {
            fatalError("Expected an active conversation") // FIXME: - Potentially handle more gracefully
        }
        
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    // MARK: - View Controller Handling

    // The flow for this function was taken from Apple's Ice Cream Builder example
    func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        let controller: UIViewController
        
        if (presentationStyle == .compact) {
            controller = instantiateInitialViewController()
        } else {
            // TODO: - Show the actual game screen
            
            // Temp
            controller = UIViewController()
        }
        
        // Remove all children from the view
        for childViewController in childViewControllers {
            childViewController.willMove(toParentViewController: nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
        }
        
        // Embed the new controller
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    func instantiateInitialViewController() -> UIViewController {
        let controller = InitialViewController()
        // Add properties as needed here
        return controller
    }
}
