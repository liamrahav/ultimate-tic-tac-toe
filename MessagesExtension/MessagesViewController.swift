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
        if let conversation = activeConversation{
            presentViewController(for: conversation, with: presentationStyle)
        } else {
            fillViewWithSubview(child: ErrorViewController(message: "Expected an active conversation"))
        }
        

    }
    
    // MARK: - View Controller Handling

    // The flow for this function was taken from Apple's Ice Cream Builder example
    func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle){
        let controller: UIViewController
        
        if (presentationStyle == .compact) {
            controller = instantiateInitialViewController()
        } else {
            // TODO: - Show the actual game screen
            controller = instantiateGameViewController(conversation: conversation)
        }
        
        fillViewWithSubview(child: controller)
    }
    
    public func fillViewWithSubview(child: UIViewController) {
        // Remove all children from the view
        for childViewController in childViewControllers {
            childViewController.willMove(toParentViewController: nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
        }
        
        // Embed the new controller
        addChildViewController(child)
        
        child.view.frame = view.bounds
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        
        child.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        child.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        child.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        child.didMove(toParentViewController: self)
    }

    func instantiateInitialViewController() -> UIViewController {
        let controller = InitialViewController()
        return controller
    }
    
    func instantiateGameViewController(conversation: MSConversation) -> UIViewController {
        let controller = GameViewController(conversation: conversation)
        return controller
    }
}
