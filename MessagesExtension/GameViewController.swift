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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (topLayoutGuide.length > 0 && needsDisplayGrid) {
            let mult: CGFloat = 0.025
            let minX = view.frame.width * mult
            let actualWidth = view.frame.width - (minX)
            let actualHeight = topLayoutGuide.length + (((view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length) / 2) - (actualWidth / 2))
            let subRect = CGRect(x: minX, y: actualHeight, width: actualWidth, height: actualWidth)
            
            //Horizontal Lines
            drawLine(start: CGPoint(x: subRect.minX, y: (subRect.height / 3) + subRect.minY),
                     end: CGPoint(x: subRect.maxX - subRect.minX, y: (subRect.height / 3) + subRect.minY),
                     color: .black)
            
            drawLine(start: CGPoint(x: subRect.minX, y: ((subRect.height / 3) * 2) + subRect.minY),
                     end: CGPoint(x: subRect.maxX - subRect.minX, y: ((subRect.height / 3) * 2) + subRect.minY),
                     color: .black)

            //Vertial Lines
            drawLine(start: CGPoint(x: (subRect.width / 3) + subRect.minX, y: subRect.minY),
                     end: CGPoint(x: (subRect.width / 3) + subRect.minX, y: subRect.maxY),
                     color: .black)
            
            drawLine(start: CGPoint(x: ((subRect.width / 3) * 2) + subRect.minX, y: subRect.minY),
                     end: CGPoint(x: ((subRect.width / 3) * 2) + subRect.minX, y: subRect.maxY),
                     color: .black)

            
            // Upper Left Tile [0][0]
            var battleGround = BattleGroundView(frame: CGRect(x: subRect.minX, y: subRect.minY , width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[0][0], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            // Upper Middle Tile [0][1]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX + (subRect.width / 3), y: subRect.minY , width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[0][1], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            // Upper Right Tile [0][2]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX + ((subRect.width / 3) * 2), y: subRect.minY , width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[0][2], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            
            // Middle Left Tile [1][0]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX, y: subRect.minY + (subRect.height / 3) , width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[1][0], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            // Middle Middle Tile [1][1]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX + (subRect.width / 3), y: subRect.minY + (subRect.height / 3) , width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[1][1], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            // Middle Right Tile [1][2]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX + ((subRect.width / 3) * 2), y: subRect.minY + (subRect.height / 3), width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[1][2], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            
            // Bottom Left Tile [2][0]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX, y: subRect.minY + ((subRect.height / 3) * 2) , width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[1][0], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            // Bottom Middle Tile [2][1]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX + (subRect.width / 3), y: subRect.minY + ((subRect.height / 3) * 2), width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[1][1], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            // Bottom Right Tile [2][2]
            battleGround = BattleGroundView(frame: CGRect(x: subRect.minX + ((subRect.width / 3) * 2), y: subRect.minY + ((subRect.height / 3) * 2), width: subRect.width / 3, height: subRect.height / 3), battleGround: grid.battleGrounds[1][2], currentPlayer: grid.currentPlayer)
            battleGround.isUserInteractionEnabled = true
            view.addSubview(battleGround)
            
            needsDisplayGrid = false
        }
    }
    
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if needsUpdateConstraints {
            
            needsUpdateConstraints = false
        }
    }
    
    private func drawLine(start: CGPoint, end: CGPoint, color: UIColor) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        
        self.view.layer.addSublayer(shapeLayer)
    }
}
