//
//  ErrorViewController.swift
//  Ultimate Tic Tac Toe
//
//  Created by Luke LaScala on 10/1/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//


import UIKit

class ErrorViewController: UIViewController {
    var errorMessage = ""
    let errorLabel = UILabel()


    init(message: String){
        super.init(nibName: nil, bundle:nil)
        self.errorMessage = message
    }
    
    required init?(coder aDecoder: NSCoder, errorMessage: String) {
        super.init(coder: aDecoder)
        self.errorMessage = errorMessage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var needsUpdateContraints = true
    
  

    
    override func viewDidLoad() {
        errorLabel.text = self.errorMessage
        
        super.viewDidLoad()
        
        view.addSubview(errorLabel)
        
        view.backgroundColor = .white
        updateViewConstraints()
    }
   
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if (needsUpdateContraints) {
            errorLabel.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(view)
            }
            
            needsUpdateContraints = false
        }
    }
}
