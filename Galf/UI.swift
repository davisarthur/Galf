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
    
    var parLabel: SKLabelNode = SKLabelNode(text: "")
    var nameLabel: SKLabelNode = SKLabelNode(text: "")
    var holeLabel: SKLabelNode = SKLabelNode(text: "")
    var lieLabel: SKLabelNode = SKLabelNode(text: "0")
    var scoreLabel: SKLabelNode = SKLabelNode(text: "E")
    
     // required initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp() {
        addChild(scoreLabel)
        scoreLabel.fontSize = CGFloat(22.0)
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: size.width / 7.0, y: size.height / 16.0)
        addChild(parLabel)
        parLabel.fontSize = CGFloat(22.0)
        parLabel.fontColor = UIColor.black
        parLabel.position = CGPoint(x: -size.width / 8.0, y: -size.height / 2.5)
        addChild(nameLabel)
        nameLabel.fontSize = CGFloat(22.0)
        nameLabel.fontColor = UIColor.black
        nameLabel.position = CGPoint(x: -1.0 * size.width / 4.0, y: size.height / 16.0)
        addChild(holeLabel)
        holeLabel.fontSize = CGFloat(22.0)
        holeLabel.fontColor = UIColor.black
        holeLabel.position = CGPoint(x: -1.0 * size.width / 3.1, y: -size.height / 2.5)
        addChild(lieLabel)
        lieLabel.fontSize = CGFloat(22.0)
        lieLabel.fontColor = UIColor.black
        lieLabel.position = CGPoint(x: 0.0, y: -size.height / 2.5)
    }
    
    func updatePlayer(playerName: String) {
        nameLabel.text = playerName
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
    
    func loadHole(num: Int, holeIn: Hole) {
        holeLabel.text = String(num)
        parLabel.text = String(holeIn.getPar())
        resetStrokes()
    }
    
    func addStroke() {
        let strokeBefore = Int(lieLabel.text!)
        lieLabel.text = String(strokeBefore! + 1)
    }
    
    func resetStrokes() {
        lieLabel.text = "0"
    }
}
