//
//  GreenerPastures.swift
//  Galf
//
//  Created by Davis Arthur on 5/2/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct GreenerPastures {
    
    let holeScenes = [SKScene(fileNamed: "GP1"), SKScene(fileNamed: "GP2")]
    var holes: [Hole] = []
    var cursor = 0
    
    init() {
        extract()
    }
    
    // Extract the data from the scene used to design hole
    mutating func extract() {
        for scene in holeScenes {
            let tileMap = scene?.childNode(withName: "tileMap") as! SKTileMapNode
            let pin = scene?.childNode(withName: "pin") as! SKSpriteNode
            let teePad = scene?.childNode(withName: "teePad") as! SKSpriteNode
            let parLabel = scene?.childNode(withName: "par") as! SKLabelNode
            let par = Int(parLabel.text!)
            let newHole = Hole(parIn: par!, pinIn: pin, teePadIn: teePad, tileMapIn: tileMap)
            holes.append(newHole)
        }
    }
    
    // Return the next hole on the course
    mutating func nextHole() -> Hole {
        let nextHole = holes[cursor]
        cursor += 1
        return nextHole
    }
    
}
