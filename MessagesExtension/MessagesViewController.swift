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
        controller.delegate = self
        return controller
    }
    
    func instantiateGameViewController(conversation: MSConversation) -> UIViewController {
        let controller = GameViewController(conversation: conversation)
        controller.delegate = self
        return controller
    }
}

extension MessagesViewController: InitialViewControllerDelegate {
    func initialViewControllerDelegate(_ controller: InitialViewController) {
        requestPresentationStyle(.expanded)
    }
}

extension MessagesViewController: GameViewControllerDelegate {
    func gameViewControllerDelegate(_ controller: GameViewController, grid: Grid) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        
        UIGraphicsBeginImageContextWithOptions(controller.view.bounds.size, false, UIScreen.main.scale)
        view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        var image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = controller.subRect.width
        var cgheight: CGFloat = controller.subRect.height
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX,y: posY,width: cgwidth,height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        image = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        var messageString = ""
        
        if grid.winner != nil {
            messageString = (grid.winner?.queryItem.value)!.uppercased() + " won!"
        } else {
            messageString = "Your turn!"
        }
        
        let message = MSMessage(grid: grid, caption: messageString, image: image, session: conversation.selectedMessage?.session)
        
        conversation.insert(message)
        dismiss()
    }
    
}
