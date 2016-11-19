//
//  BattleGroundView.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 10/26/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit

class BattleGroundView: UIView {
    let battleGround: BattleGround
    let currentPlayer: Tile
    
    init(frame: CGRect, battleGround: BattleGround, currentPlayer: Tile) {
        self.battleGround = battleGround
        self.currentPlayer = currentPlayer
        
        super.init(frame: frame)
        clipsToBounds = true
       
        //Horizontal Lines
        drawLine(start: CGPoint(x: frame.minX, y: (frame.height / 3) + frame.minY),
                 end: CGPoint(x: frame.maxX - frame.minX, y: (frame.height / 3) + frame.minY),
                 color: .black)
        
        drawLine(start: CGPoint(x: frame.minX, y: ((frame.height / 3) * 2) + frame.minY),
                 end: CGPoint(x: frame.maxX - frame.minX, y: ((frame.height / 3) * 2) + frame.minY),
                 color: .black)
        
        //Vertial Lines
        drawLine(start: CGPoint(x: (frame.width / 3) + frame.minX, y: frame.minY),
                 end: CGPoint(x: (frame.width / 3) + frame.minX, y: frame.maxY),
                 color: .black)
        
        drawLine(start: CGPoint(x: ((frame.width / 3) * 2) + frame.minX, y: frame.minY),
                 end: CGPoint(x: ((frame.width / 3) * 2) + frame.minX, y: frame.maxY),
                 color: .black)
        
//        battleGround.tiles[0][0] = .o
//        battleGround.tiles[0][1] = .x
//        battleGround.tiles[0][2] = .o
//        
//        battleGround.tiles[1][0] = .x
//        battleGround.tiles[1][1] = .x
//        battleGround.tiles[1][2] = .x
//        
//        battleGround.tiles[2][0] = .x
//        battleGround.tiles[2][1] = .x
//        battleGround.tiles[2][2] = .x
        
        drawTiles()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawTiles() {
        for view in subviews {
            if (view as? UIImageView != nil) {
                view.removeFromSuperview()
            }
        }
        
        // Upper Left Tile [0][0]
        var view = UIImageView(image: battleGround.tiles[0][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // Upper Middle Tile [0][1]
        view = UIImageView(image: battleGround.tiles[0][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + frame.width / 3, y: frame.minY, width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // Upper Right Tile [0][2]
        view = UIImageView(image: battleGround.tiles[0][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3) * 2), y: frame.minY, width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        
        
        // Middle Left Tile [1][0]
        view = UIImageView(image: battleGround.tiles[1][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX, y: frame.minY + ((frame.height / 3)), width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // Middle Center Tile [1][1]
        view = UIImageView(image: battleGround.tiles[1][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3)), y: frame.minY + ((frame.height / 3)), width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // Middle Center Tile [1][2]
        view = UIImageView(image: battleGround.tiles[1][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3) * 2), y: frame.minY + ((frame.height / 3)), width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // FIXME: Only clicking the top of the next 3 views works
        
        // Lower Left Tile [2][0]
        view = UIImageView(image: battleGround.tiles[2][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX, y: frame.minY + ((frame.height / 3) * 2), width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // Lower Center Tile [2][1]
        view = UIImageView(image: battleGround.tiles[2][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3)), y: frame.minY + ((frame.height / 3) * 2), width: frame.width / 3, height: frame.height / 3)
        addSubview(view)
        
        // Lower Right Tile [2][2]
        view = UIImageView(image: battleGround.tiles[2][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3) * 2), y: frame.minY + ((frame.height / 3) * 2), width: frame.width / 3, height:frame.height / 3)
        addSubview(view)
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
    
    func lowerLeftTapped() {
        tapped(row: 2, column: 0)
    }
    
    func lowerCenterTapped() {
        tapped(row: 2, column: 1)
    }
    
    func lowerRightTapped() {
        tapped(row: 2, column: 2)
    }
    
    func tapped(row: Int, column: Int) {
        if (battleGround.tiles[row][column] == .empty) {
            battleGround.tiles[row][column] = currentPlayer
            
            drawTiles()
        }
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
        shapeLayer.lineWidth = 1.0
    
        self.layer.addSublayer(shapeLayer)
    }
}
