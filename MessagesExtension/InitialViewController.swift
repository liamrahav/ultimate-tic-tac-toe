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
    
    weak var delegate: InitialViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
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
        delegate?.initialViewControllerDelegate(self)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if (needsUpdateContraints) {
            newGameButton.snp.makeConstraints { make in
                make.center.equalTo(view)
            }
            
            needsUpdateContraints = false
        }
    }
}

protocol InitialViewControllerDelegate: class {
    func initialViewControllerDelegate(_ controller: InitialViewController)
}
