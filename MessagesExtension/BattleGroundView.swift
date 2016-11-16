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
    
    init(frame: CGRect, battleGround: BattleGround) {
        self.battleGround = battleGround

        super.init(frame: frame)
       
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
        
        battleGround.tiles[0][0] = .o
        battleGround.tiles[0][1] = .x
        battleGround.tiles[0][2] = .o
        
        battleGround.tiles[1][0] = .x
        battleGround.tiles[1][1] = .x
        battleGround.tiles[1][2] = .x
        
        battleGround.tiles[2][0] = .x
        battleGround.tiles[2][1] = .x
        battleGround.tiles[2][2] = .x
        

        
        // Upper Left Tile [0][0]
        var view = UIImageView(image: battleGround.tiles[0][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        // Upper Middle Tile [0][1]
        view = UIImageView(image: battleGround.tiles[0][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + frame.width / 3, y: frame.minY, width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        // Upper Right Tile [0][2]
        view = UIImageView(image: battleGround.tiles[0][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3) * 2), y: frame.minY, width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        
        // Middle Left Tile [1][0]
        view = UIImageView(image: battleGround.tiles[1][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX, y: frame.minY + ((frame.height / 3)), width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        // Middle Center Tile [1][1]
        view = UIImageView(image: battleGround.tiles[1][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3)), y: frame.minY + ((frame.height / 3)), width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        // Middle Center Tile [1][2]
        view = UIImageView(image: battleGround.tiles[1][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3) * 2), y: frame.minY + ((frame.height / 3)), width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        
        
        // Middle Left Tile [2][0]
        view = UIImageView(image: battleGround.tiles[2][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX, y: frame.minY + ((frame.height / 3) * 2), width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        // Middle Center Tile [2][1]
        view = UIImageView(image: battleGround.tiles[2][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3)), y: frame.minY + ((frame.height / 3) * 2), width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        // Middle Center Tile [2][2]
        view = UIImageView(image: battleGround.tiles[2][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: frame.minX + ((frame.width / 3) * 2), y: frame.minY + ((frame.height / 3) * 2), width: frame.width / 3, height: frame.width / 3)
        addSubview(view)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func upperLeftTapped() {
        print("JAH")
    }
    
    func upperCenterTapped(){
        print("JAH2")
    }
    
    func upperRightTapped() {
        print("JAH3")
    }
    
    func middleLeftTapped() {
        print("JAH3")
    }
    
    func middleCenterTapped() {
        print("JAH3")
    }
    func middleRightTapped() {
        print("JAH3")
    }
    
    func lowerLeftTapped() {
        print("JAH3")
    }
    
    func lowerCenterTapped() {
        print("JAH3")
    }
    func lowerRightTapped() {
        print("JAH3")
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
