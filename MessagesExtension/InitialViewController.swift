//
//  InitialViewController.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/29/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit
import Messages

class InitialViewController: UIViewController {

    var needsUpdateContraints = true
    
    let newGameButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Start New Game", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startGame)))
        view.addSubview(newGameButton)
        
        view.backgroundColor = .white
        updateViewConstraints()
    }
    
    func startGame() {
        let messagesVC = parent as! MessagesViewController
        if let conversation = messagesVC.activeConversation {
            let message = MSMessage(grid: Grid(), caption: "Your turn!", session: conversation.selectedMessage?.session)
            conversation.insert(message) { error in
                messagesVC.fillViewWithSubview(child: ErrorViewController(message: error.debugDescription))
            }
        } else {
            messagesVC.fillViewWithSubview(child: ErrorViewController(message: "Expected an active conversation"))
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if (needsUpdateContraints) {
            newGameButton.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(view)
            }
            
            needsUpdateContraints = false
        }
    }
}
