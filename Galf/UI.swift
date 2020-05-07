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

class UI : SKShapeNode {
    
    var parLabel: SKLabelNode = SKLabelNode(text: "")
    var nameLabel: SKLabelNode = SKLabelNode(text: "")
    var holeLabel: SKLabelNode = SKLabelNode(text: "")
    var lieLabel: SKLabelNode = SKLabelNode(text: "0")
    
     // required initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp(sceneIn: GameScene) {
        addChild(parLabel)
        addChild(nameLabel)
        addChild(holeLabel)
        addChild(lieLabel)
    }
    
    func updatePlayer(playerName: String) {
        nameLabel.text = playerName
    }
    
    func loadHole(num: Int, holeIn: Hole) {
        holeLabel.text = String(num)
        parLabel.text = String(holeIn.getPar())
    }
    
    func addStroke() {
        let strokeBefore = Int(lieLabel.text!)
        lieLabel.text = String(strokeBefore! + 1)
    }
}
