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
        if (activeConversation != nil){
            let conversation = activeConversation
            presentViewController(for: conversation!, with: presentationStyle)
        } else {
            presentErrorViewController(with: presentationStyle, errorMessage: "hi")
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
            
            // Temp
            controller = UIViewController()
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

    
    // The flow for this function was taken from Apple's Ice Cream Builder example
    func presentErrorViewController(with presentationStyle: MSMessagesAppPresentationStyle, errorMessage: String){
        let controller: UIViewController
        
        if (presentationStyle == .compact) {
            controller = instantiateErrorViewController(errorMessage: errorMessage)
        } else {
            controller = instantiateErrorViewController(errorMessage: errorMessage)
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
    
    func instantiateErrorViewController(errorMessage: String) -> UIViewController {
        let controller = ErrorViewController(message: errorMessage)
        // Add properties as needed here
        return controller
    }
}
