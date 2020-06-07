//
//  UI.swift
//  Galf
//
//  Created by Davis Arthur on 5/4/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class UI : SKSpriteNode {
    
    var handler: GameHandler? = nil
    var parLabel: SKLabelNode = SKLabelNode(text: "")
    var nameLabel: SKLabelNode = SKLabelNode(text: "")
    var holeLabel: SKLabelNode = SKLabelNode(text: "")
    var lieLabel: SKLabelNode = SKLabelNode(text: "0")
    var scoreLabel: SKLabelNode = SKLabelNode(text: "E")
    
     // required initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp(handlerIn: GameHandler) {
        addChild(scoreLabel)
        scoreLabel.text = String(scoreToString(scoreIn: handlerIn.players[0].totalScore))
        scoreLabel.fontSize = CGFloat(12.0)
        scoreLabel.fontName = "I pixel u"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: -size.width / 7.0 * 0.1, y: size.height / 16.0)
        scoreLabel.zPosition = CGFloat(15.0)
        
        addChild(parLabel)
        let parTitle = SKLabelNode(text: "Par")
        parTitle.fontName = "I pixel u"
        parTitle.fontSize = CGFloat(12.0)
        parTitle.fontColor = UIColor.black
        parTitle.position = CGPoint(x: 0.25 * size.width / 4.0, y: -size.height / 3.5)
        parTitle.zPosition = CGFloat(15.0)
        addChild(parTitle)
        parLabel.text = String(handlerIn.course.getHole(holeNum: handlerIn.currentHole)!.par)
        parLabel.fontSize = CGFloat(12.0)
        parLabel.fontName = "I pixel u"
        parLabel.fontColor = UIColor.black
        parLabel.position = CGPoint(x: 0.75 * size.width / 4.0, y: -size.height / 3.5)
        parLabel.zPosition = CGFloat(15.0)
        
        addChild(nameLabel)
        nameLabel.text = handlerIn.players[0].playerName
        nameLabel.fontSize = CGFloat(12.0)
        nameLabel.fontName = "I pixel u"
        nameLabel.fontColor = UIColor.black
        nameLabel.position = CGPoint(x: -0.8 * size.width / 4.0, y: size.height / 16.0)
        nameLabel.zPosition = CGFloat(15.0)
        
        addChild(holeLabel)
        let holeTitle = SKLabelNode(text: "Hole")
        holeTitle.fontName = "I pixel u"
        holeTitle.fontSize = CGFloat(12.0)
        holeTitle.fontColor = UIColor.black
        holeTitle.position = CGPoint(x: -0.7 * size.width / 3.0, y: -size.height / 3.5)
        holeTitle.zPosition = CGFloat(15.0)
        addChild(holeTitle)
        holeLabel.text = String(handlerIn.currentHole)
        holeLabel.fontSize = CGFloat(12.0)
        holeLabel.fontName = "I pixel u"
        holeLabel.fontColor = UIColor.black
        holeLabel.position = CGPoint(x: -0.25 * size.width / 3.0, y: -size.height / 3.5)
        holeLabel.zPosition = CGFloat(15.0)
        
        addChild(lieLabel)
        let lieTitle = SKLabelNode(text: "Lie")
        lieTitle.fontName = "I pixel u"
        lieTitle.fontSize = CGFloat(13.0)
        lieTitle.fontColor = UIColor.black
        lieTitle.position = CGPoint(x: 0.45 * size.width / 3.0, y: size.height / 16.0)
        lieTitle.zPosition = CGFloat(15.0)
        addChild(lieTitle)
        lieLabel.fontSize = CGFloat(13.0)
        lieLabel.fontName = "I pixel u"
        lieLabel.fontColor = UIColor.black
        lieLabel.position = CGPoint(x: 0.85 * size.width / 3.0, y: size.height / 16.0)
        lieLabel.zPosition = CGFloat(15.0)
    }
    
    func scoreToString(scoreIn: Int) -> String {
        if (scoreIn == 0) {
            return "E"
        }
        return String(scoreIn)
    }
    
    func updateScore() {
        var newScore = 0
        if scoreLabel.text == "E" {
            newScore = Int(lieLabel.text!)! - Int(parLabel.text!)!
        }
        else {
            newScore = Int(scoreLabel.text!)! + Int(lieLabel.text!)! - Int(parLabel.text!)!
        }
        if newScore == 0 {
            scoreLabel.text = "E"
        }
        else {
            scoreLabel.text = String(newScore)
        }
        
    }
    
    func addStroke() {
        let strokeBefore = Int(lieLabel.text!)
        lieLabel.text = String(strokeBefore! + 1)
    }
    
    func resetStrokes() {
        lieLabel.text = "0"
    }
}
