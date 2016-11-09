//
//  BattleGroundView.swift
//  Ultimate Tic Tac Toe
//
//  Created by Liam Rahav on 10/26/16.
//  Copyright © 2016 Liam Rahav. All rights reserved.
//

import UIKit

class BattleGroundView: UIView {
    
    override init(frame: CGRect) {
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
        
        //drawLine(start: CGPoint(x: frame.minX, y: frame.maxY), end: CGPoint(x: frame.maxX, y: frame.maxY), color: .black)
        
        print("maxX: \(frame.maxX)")
        print("maxY: \(frame.maxY)")
        
        print("minY: \(frame.minY)")
        print("minX: \(frame.minX)")
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
        shapeLayer.lineWidth = 1.0
    
        self.layer.addSublayer(shapeLayer)
    }
}
