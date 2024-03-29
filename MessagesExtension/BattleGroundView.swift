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
    var delegate: BattleGroundDelegate?
    var lastChoice: (row: Int, column: Int)?
    
    init(frame: CGRect, battleGround: BattleGround, currentPlayer: Tile) {
        self.battleGround = battleGround
        self.currentPlayer = currentPlayer
        
        super.init(frame: frame)
        clipsToBounds = true
       
        drawTilesGameView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawTilesGameView() {
        layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() }}
        for view in subviews {
            if (view as? UIImageView != nil) {
                view.removeFromSuperview()
            }
        }
        
        if battleGround.winner != nil {
            let view = UIImageView(image: UIImage(named: (battleGround.winner?.queryItem.value)!))
            view.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
            addSubview(view)
        } else {
            //Horizontal Lines
            drawLine(start: CGPoint(x: bounds.minX, y: (bounds.height / 3) + bounds.minY),
                     end: CGPoint(x: bounds.maxX - bounds.minX, y: (bounds.height / 3) + bounds.minY),
                     color: .black)
            
            drawLine(start: CGPoint(x: bounds.minX, y: ((bounds.height / 3) * 2) + bounds.minY),
                     end: CGPoint(x: bounds.maxX - bounds.minX, y: ((bounds.height / 3) * 2) + bounds.minY),
                     color: .black)
            
            //Vertial Lines
            drawLine(start: CGPoint(x: (bounds.width / 3) + bounds.minX, y: bounds.minY),
                     end: CGPoint(x: (bounds.width / 3) + bounds.minX, y: bounds.maxY),
                     color: .black)
            
            drawLine(start: CGPoint(x: ((bounds.width / 3) * 2) + bounds.minX, y: bounds.minY),
                     end: CGPoint(x: ((bounds.width / 3) * 2) + bounds.minX, y: bounds.maxY),
                     color: .black)
            
            
            // Upper Left Tile [0][0]
            var view = UIImageView(image: battleGround.tiles[0][0].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperLeftTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Upper Middle Tile [0][1]
            view = UIImageView(image: battleGround.tiles[0][1].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperCenterTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX + bounds.width / 3, y: bounds.minY, width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Upper Right Tile [0][2]
            view = UIImageView(image: battleGround.tiles[0][2].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperRightTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX + ((bounds.width / 3) * 2), y: bounds.minY, width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            
            
            // Middle Left Tile [1][0]
            view = UIImageView(image: battleGround.tiles[1][0].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleLeftTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX, y: bounds.minY + ((bounds.height / 3)), width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Middle Center Tile [1][1]
            view = UIImageView(image: battleGround.tiles[1][1].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleCenterTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX + ((bounds.width / 3)), y: bounds.minY + ((bounds.height / 3)), width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Middle Center Tile [1][2]
            view = UIImageView(image: battleGround.tiles[1][2].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleRightTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX + ((bounds.width / 3) * 2), y: bounds.minY + ((bounds.height / 3)), width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Lower Left Tile [2][0]
            view = UIImageView(image: battleGround.tiles[2][0].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerLeftTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX, y: bounds.minY + ((bounds.height / 3) * 2), width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Lower Center Tile [2][1]
            view = UIImageView(image: battleGround.tiles[2][1].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerCenterTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX + ((bounds.width / 3)), y: bounds.minY + ((bounds.height / 3) * 2), width: bounds.width / 3, height: bounds.height / 3)
            addSubview(view)
            
            // Lower Right Tile [2][2]
            view = UIImageView(image: battleGround.tiles[2][2].image)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerRightTapped)))
            view.isUserInteractionEnabled = true
            view.frame = CGRect(x: bounds.minX + ((bounds.width / 3) * 2), y: bounds.minY + ((bounds.height / 3) * 2), width: bounds.width / 3, height:bounds.height / 3)
            addSubview(view)
        }
    }
    
    func drawTilesBattleGroundView() {
        layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() }}
        for view in subviews {
            if (view as? UIImageView != nil) {
                view.removeFromSuperview()
            }
        }
        
        //Horizontal Lines
        drawLine(start: CGPoint(x: bounds.minX, y: (bounds.height / 3) + bounds.minY),
                 end: CGPoint(x: bounds.maxX - bounds.minX, y: (bounds.height / 3) + bounds.minY),
                 color: .black)

        drawLine(start: CGPoint(x: bounds.minX, y: ((bounds.height / 3) * 2) + bounds.minY),
                 end: CGPoint(x: bounds.maxX - bounds.minX, y: ((bounds.height / 3) * 2) + bounds.minY),
                 color: .black)

        //Vertial Lines
        drawLine(start: CGPoint(x: (bounds.width / 3) + bounds.minX, y: bounds.minY),
                 end: CGPoint(x: (bounds.width / 3) + bounds.minX, y: bounds.maxY),
                 color: .black)

        drawLine(start: CGPoint(x: ((bounds.width / 3) * 2) + bounds.minX, y: bounds.minY),
                 end: CGPoint(x: ((bounds.width / 3) * 2) + bounds.minX, y: bounds.maxY),
                 color: .black)


        // Upper Left Tile [0][0]
        var view = UIImageView(image: battleGround.tiles[0][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Upper Middle Tile [0][1]
        view = UIImageView(image: battleGround.tiles[0][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX + bounds.width / 3, y: bounds.minY, width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Upper Right Tile [0][2]
        view = UIImageView(image: battleGround.tiles[0][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX + ((bounds.width / 3) * 2), y: bounds.minY, width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)



        // Middle Left Tile [1][0]
        view = UIImageView(image: battleGround.tiles[1][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX, y: bounds.minY + ((bounds.height / 3)), width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Middle Center Tile [1][1]
        view = UIImageView(image: battleGround.tiles[1][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX + ((bounds.width / 3)), y: bounds.minY + ((bounds.height / 3)), width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Middle Center Tile [1][2]
        view = UIImageView(image: battleGround.tiles[1][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX + ((bounds.width / 3) * 2), y: bounds.minY + ((bounds.height / 3)), width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Lower Left Tile [2][0]
        view = UIImageView(image: battleGround.tiles[2][0].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerLeftTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX, y: bounds.minY + ((bounds.height / 3) * 2), width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Lower Center Tile [2][1]
        view = UIImageView(image: battleGround.tiles[2][1].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerCenterTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX + ((bounds.width / 3)), y: bounds.minY + ((bounds.height / 3) * 2), width: bounds.width / 3, height: bounds.height / 3)
        addSubview(view)

        // Lower Right Tile [2][2]
        view = UIImageView(image: battleGround.tiles[2][2].image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lowerRightTapped)))
        view.isUserInteractionEnabled = true
        view.frame = CGRect(x: bounds.minX + ((bounds.width / 3) * 2), y: bounds.minY + ((bounds.height / 3) * 2), width: bounds.width / 3, height:bounds.height / 3)
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
            if (lastChoice != nil) {
                battleGround.tiles[lastChoice!.row][lastChoice!.column] = .empty
            }
            lastChoice = (row: row, column: column)
            drawTilesBattleGroundView()
            
            delegate?.moveMade(row: row, column: column)
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
        shapeLayer.lineWidth = 1.0
    
        self.layer.addSublayer(shapeLayer)
    }
}
