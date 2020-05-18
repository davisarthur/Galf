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
        scoreLabel.fontSize = CGFloat(22.0)
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: size.width / 7.0, y: size.height / 16.0)
        addChild(parLabel)
        parLabel.text = String(handlerIn.course.getHole(holeNum: handlerIn.currentHole)!.par)
        parLabel.fontSize = CGFloat(22.0)
        parLabel.fontColor = UIColor.black
        parLabel.position = CGPoint(x: -size.width / 8.0, y: -size.height / 2.5)
        addChild(nameLabel)
        nameLabel.text = handlerIn.players[0].name
        nameLabel.fontSize = CGFloat(22.0)
        nameLabel.fontColor = UIColor.black
        nameLabel.position = CGPoint(x: -1.0 * size.width / 4.0, y: size.height / 16.0)
        addChild(holeLabel)
        holeLabel.text = String(handlerIn.currentHole)
        holeLabel.fontSize = CGFloat(22.0)
        holeLabel.fontColor = UIColor.black
        holeLabel.position = CGPoint(x: -1.0 * size.width / 3.1, y: -size.height / 2.5)
        addChild(lieLabel)
        lieLabel.fontSize = CGFloat(22.0)
        lieLabel.fontColor = UIColor.black
        lieLabel.position = CGPoint(x: 0.0, y: -size.height / 2.5)
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
