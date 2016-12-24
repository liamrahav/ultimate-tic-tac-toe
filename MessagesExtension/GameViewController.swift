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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (topLayoutGuide.length > 0 && needsDisplayGrid) {
            let mult: CGFloat = 0.025
            let minX = view.frame.width * mult
            let actualWidth = view.frame.width - (minX * 2)
            let actualHeight = topLayoutGuide.length + (((view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length) / 2) - (actualWidth / 2))
            let subRect = CGRect(x: minX, y: actualHeight, width: actualWidth, height: actualWidth)
            
            //Horizontal Lines
            drawLine(start: CGPoint(x: subRect.minX, y: (subRect.height / 3) + subRect.minY),
                     end: CGPoint(x: subRect.minX + subRect.width, y: (subRect.height / 3) + subRect.minY),
                     color: .black)
            
            drawLine(start: CGPoint(x: subRect.minX, y: ((subRect.height / 3) * 2) + subRect.minY),
                     end: CGPoint(x: subRect.minX + subRect.width, y: ((subRect.height / 3) * 2) + subRect.minY),
                     color: .black)

            //Vertial Lines
            drawLine(start: CGPoint(x: (subRect.width / 3) + subRect.minX, y: subRect.minY),
                     end: CGPoint(x: (subRect.width / 3) + subRect.minX, y: subRect.maxY),
                     color: .black)
            
            drawLine(start: CGPoint(x: ((subRect.width / 3) * 2) + subRect.minX, y: subRect.minY),
                     end: CGPoint(x: ((subRect.width / 3) * 2) + subRect.minX, y: subRect.maxY),
                     color: .black)
            
            
            let insetMultiplier: CGFloat = 0.05
            let inset = (subRect.width / 3) * insetMultiplier
            
            // Upper Left Tile [0][0]
            configureBattleGround(
                row: 0, column: 0,
                frame: CGRect(x: subRect.minX + inset, y: subRect.minY + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(upperLeftTapped)
            )
            
            // Upper Middle Tile [0][1]
            configureBattleGround(
                row: 0, column: 1,
                frame: CGRect(x: subRect.minX + (subRect.width / 3) + inset, y: subRect.minY + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(upperCenterTapped)
            )
            
            // Upper Right Tile [0][2]
            configureBattleGround(
                row: 0, column: 2,
                frame: CGRect(x: subRect.minX + ((subRect.width / 3) * 2) + inset, y: subRect.minY + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(upperRightTapped)
            )
            
            
            // Middle Left Tile [1][0]
            configureBattleGround(
                row: 1, column: 0,
                frame: CGRect(x: subRect.minX + inset, y: subRect.minY + (subRect.height / 3) + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(middleLeftTapped)
            )
            
            // Middle Center Tile [1][1]
            configureBattleGround(
                row: 1, column: 1,
                frame: CGRect(x: subRect.minX + (subRect.width / 3) + inset, y: subRect.minY + (subRect.height / 3) + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(middleCenterTapped)
            )
            
            // Middle Right Tile [1][2]
            configureBattleGround(
                row: 1, column: 2,
                frame: CGRect(x: subRect.minX + ((subRect.width / 3) * 2) + inset, y: subRect.minY + (subRect.height / 3) + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(middleRightTapped)
            )
            
            
            // Bottom Left Tile [2][0]
            configureBattleGround(
                row: 2, column: 0,
                frame: CGRect(x: subRect.minX + inset, y: subRect.minY + ((subRect.height / 3) * 2) + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(bottomLeftTapped)
            )
            
            // Bottom Middle Tile [2][1]
            configureBattleGround(
                row: 2, column: 1,
                frame: CGRect(x: subRect.minX + (subRect.width / 3) + inset, y: subRect.minY + ((subRect.height / 3) * 2) + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(bottomCenterTapped)
            )
            
            // Bottom Right Tile [2][2]
            configureBattleGround(
                row: 2, column: 2,
                frame: CGRect(x: subRect.minX + ((subRect.width / 3) * 2) + inset, y: subRect.minY + ((subRect.height / 3) * 2) + inset, width: (subRect.width / 3) - (2 * inset), height: (subRect.height / 3) - (2 * inset)),
                selector: #selector(bottomRightTapped)
            )
            
            needsDisplayGrid = false
        }
    }
    
    func configureBattleGround(row: Int, column: Int, frame: CGRect, selector: Selector) {
        let battleGround = BattleGroundView(frame: frame, battleGround: grid.battleGrounds[row][column], currentPlayer: grid.currentPlayer)
        battleGround.subviews.forEach { $0.isUserInteractionEnabled = false }
        battleGround.isUserInteractionEnabled = true
        battleGround.delegate = self
        battleGround.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        view.addSubview(battleGround)
    }
    
    func upperLeftTapped() {
        tapped(row: 0, column: 0)
    }
    
    func upperCenterTapped(){
        tapped(row: 0, column: 1)
    }
    
    func upperRightTapped() {
        tapped(row: 0, column: 2)
    }
    
    func middleLeftTapped() {
        tapped(row: 1, column: 0)
    }
    
    func middleCenterTapped() {
        tapped(row: 1, column: 1)
    }
    
    func middleRightTapped() {
        tapped(row: 1, column: 2)
    }
    
    func bottomLeftTapped() {
        tapped(row: 2, column: 0)
    }
    
    func bottomCenterTapped() {
        tapped(row: 2, column: 1)
    }
    
    func bottomRightTapped() {
        tapped(row: 2, column: 2)
    }
    
    func tapped(row: Int, column: Int) {
        print("ROW: \(row)\nCOLUMN: \(column)")
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

extension GameViewController: BattleGroundDelegate {
    func moveMade() {
        print("move made")
    }
}
