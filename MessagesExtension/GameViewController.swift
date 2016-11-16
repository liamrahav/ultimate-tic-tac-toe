//
//  GameViewController.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 10/5/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit
import Messages

class GameViewController: UIViewController {

    var conversation: MSConversation
    var grid: Grid
    
    var needsUpdateConstraints = true
    var needsDisplayGrid = true
    
    init(conversation: MSConversation) {
        self.conversation = conversation
        
        guard let url = conversation.selectedMessage!.url else {
            fatalError("invalid URL")
        }
        
        guard let components = NSURLComponents(string: url.absoluteString) else {
            fatalError("Invalid base url")
        }
        
        grid = Grid(queryItems: components.queryItems!)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLine(start: CGPoint, end: CGPoint, color: UIColor) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 150.0
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (topLayoutGuide.length > 0 && needsDisplayGrid) {
            let widthMultiplier: CGFloat = 0.05
            let width = view.bounds.width - (view.bounds.width * widthMultiplier) - (view.bounds.width * widthMultiplier) / 2
            let battleGroundView = BattleGroundView(frame: CGRect(x: (view.bounds.width * widthMultiplier) / 2,
                                                                  y: (view.bounds.height - topLayoutGuide.length - bottomLayoutGuide.length - view.bounds.width) / 2,
                                                                  width: width,
                                                                  height: width),
                                                    battleGround: grid.battleGrounds[0][0])

            
            view.addSubview(battleGroundView)
            needsDisplayGrid = false
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if needsUpdateConstraints {

            needsUpdateConstraints = false
        }
    }
}
