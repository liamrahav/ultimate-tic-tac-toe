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
    var grid: Grid
    var needsDisplayGrid = true
    var needsUpdateConstraints = true
    var needsAddSendButton = true
    var battleGroundViews = [[BattleGroundView?]]()
    var lastFrame: CGRect?
    var lastRow: Int?
    var lastCol: Int?
    
    weak var delegate: GameViewControllerDelegate?
    
    var subRect: CGRect {
        let mult: CGFloat = 0.025
        let minX = view.frame.width * mult
        let actualWidth = view.frame.width - (minX * 2)
        let actualHeight = topLayoutGuide.length + (((view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length) / 2) - (actualWidth / 2))
        return CGRect(x: minX, y: actualHeight, width: actualWidth, height: actualWidth)
    }
    
    
    init(conversation: MSConversation) {
        if conversation.selectedMessage != nil {
            guard let url = conversation.selectedMessage!.url else {
                fatalError("invalid URL")
            }
            
            guard let components = NSURLComponents(string: url.absoluteString) else {
                fatalError("Invalid base url")
            }
            
            grid = Grid(queryItems: components.queryItems!)
        } else {
            grid = Grid()
        }
        
        for i in 0 ... 2 {
            battleGroundViews.append([BattleGroundView?]())
            for _ in 0 ... 2 {
                battleGroundViews[i].append(nil)
            }
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (topLayoutGuide.length > 0 && needsDisplayGrid) {
            drawLines(withColor: .black)
            
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
    
    func addBackButton() {
        super.viewDidLoad()
        
        var backButton: UIButton {
            let offset = view.frame.height * 0.025
            let button = UIButton(frame: CGRect(x: offset, y: topLayoutGuide.length + offset, width: 70, height: 40))
            button.setTitle("Back", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            button.layer.cornerRadius = 10
            return button
        }
        
        view.addSubview(backButton)
    }
    
    func backButtonTapped() {
        zoomOut(completionHandler: nil)
    }
    
    func zoomOut(completionHandler: (() -> Void)?){
        //var tappedOne = (self.view.subviews.filter { $0 is BattleGroundView })[0]
        for x in 0...2{
            for y in 0...2{
                view.addSubview(battleGroundViews[x][y]!)
            }
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.battleGroundViews[self.lastRow!][self.lastCol!]!.frame = self.lastFrame!
            self.view.addSubview(self.battleGroundViews[self.lastRow!][self.lastCol!]!)
            self.battleGroundViews[self.lastRow!][self.lastCol!]!.drawTiles()
            }, completion: { finished in
                self.battleGroundViews[self.lastRow!][self.lastCol!]!.subviews.forEach { $0.isUserInteractionEnabled = false }
                self.drawLines(withColor: .black)
                if completionHandler != nil {
                    completionHandler!()
                }
        })
    }

    
    func configureBattleGround(row: Int, column: Int, frame: CGRect, selector: Selector) {
        let battleGround = BattleGroundView(frame: frame, battleGround: grid.battleGrounds[row][column], currentPlayer: grid.currentPlayer)
        battleGround.subviews.forEach { $0.isUserInteractionEnabled = false }
        battleGround.isUserInteractionEnabled = true
        battleGround.delegate = self
        battleGround.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        view.addSubview(battleGround)
        battleGroundViews[row][column] = battleGround
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
        // Use that short-circuit
        if grid.battleGrounds[row][column].winner == nil && (grid.nextBattleground == nil || (grid.nextBattleground?.row == row && grid.nextBattleground?.column == column)) {
            // Remove lines
            view.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() }}
            
            // Remove other battlegrounds
            for i in 0 ... 2 {
                for j in 0 ... 2 {
                    if i != row || j != column {
                        self.battleGroundViews[i][j]!.removeFromSuperview()
                    }
                }
            }
            
            self.lastFrame = self.battleGroundViews[row][column]!.frame
            self.lastRow = row
            self.lastCol = column

            UIView.animate(withDuration: 1, animations: {
                self.battleGroundViews[row][column]!.frame = self.subRect
                self.battleGroundViews[row][column]!.drawTiles()
            }, completion: { finished in
                self.battleGroundViews[row][column]!.subviews.forEach { $0.isUserInteractionEnabled = true }
                self.addBackButton()
            })
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
        shapeLayer.borderColor = color.cgColor
        shapeLayer.lineWidth = 2
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func drawLines(withColor color: UIColor) {
        //Horizontal Lines
        drawLine(start: CGPoint(x: subRect.minX, y: (subRect.height / 3) + subRect.minY),
                 end: CGPoint(x: subRect.minX + subRect.width, y: (subRect.height / 3) + subRect.minY),
                 color: color)
        
        drawLine(start: CGPoint(x: subRect.minX, y: ((subRect.height / 3) * 2) + subRect.minY),
                 end: CGPoint(x: subRect.minX + subRect.width, y: ((subRect.height / 3) * 2) + subRect.minY),
                 color: color)
        
        //Vertial Lines
        drawLine(start: CGPoint(x: (subRect.width / 3) + subRect.minX, y: subRect.minY),
                 end: CGPoint(x: (subRect.width / 3) + subRect.minX, y: subRect.maxY),
                 color: color)
        
        drawLine(start: CGPoint(x: ((subRect.width / 3) * 2) + subRect.minX, y: subRect.minY),
                 end: CGPoint(x: ((subRect.width / 3) * 2) + subRect.minX, y: subRect.maxY),
                 color: color)
    }
}

extension GameViewController: BattleGroundDelegate {
    func moveMade(row: Int, column: Int) {
        if (grid.battleGrounds[row][column].winner == nil) {
            grid.nextBattleground = (row: row, column: column)
        } else {
            grid.nextBattleground = nil
        }
        
        if needsAddSendButton {
            var sendButton: UIButton {
                let button = UIButton(frame: CGRect(x: (view.frame.width / 2) - 35, y: ((view.frame.height - bottomLayoutGuide.length) - ((view.frame.height - bottomLayoutGuide.length) - subRect.height) / 4), width: 70, height: 40))
                button.setTitle("Send", for: .normal)
                button.setTitleColor(.blue, for: .normal)
                button.layer.cornerRadius = 10
                button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendButtonPressed)))
                return button
            }
            
            view.addSubview(sendButton)
            needsAddSendButton = false
        }
    }
    
    func sendButtonPressed() {
        if grid.winner == nil {
            zoomOut(completionHandler: {
                self.delegate?.gameViewControllerDelegate(self, grid: self.grid)
            })
        } else {
            zoomOut(completionHandler: {
                self.view.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() }}
                for row in self.battleGroundViews {
                    for view in row {
                        view?.removeFromSuperview()
                    }
                }
                
                let view = UIImageView(frame: self.subRect)
                view.image = UIImage(named: (self.grid.winner?.queryItem.value)!)
                self.view.addSubview(view)
                
                self.delegate?.gameViewControllerDelegate(self, grid: self.grid)
            })
        }
    }
}

protocol GameViewControllerDelegate: class {
    func gameViewControllerDelegate(_ controller: GameViewController, grid: Grid)
}
