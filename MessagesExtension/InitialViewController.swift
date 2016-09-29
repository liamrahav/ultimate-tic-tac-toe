//
//  InitialViewController.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 9/29/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit

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
        print("booyah")
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
