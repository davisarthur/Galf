//
//  Course.swift
//  Galf
//
//  Created by Davis Arthur on 5/2/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Course {
    
    var holes: [Hole] = []
    var par = 0
    
    init(holesIn: [Hole]) {
        holes = holesIn
        par = calculatePar()
    }
    
    init(scenes: [SKScene]) {
        extract(holeScenes: scenes)
    }
    
    // Extract the data from hole scenes to generate holes hole
    private func extract(holeScenes: [SKScene]) {
        for scene in holeScenes {
            let tileMap = scene.childNode(withName: "tileMap") as! SKTileMapNode
            let pin = scene.childNode(withName: "pin") as! SKSpriteNode
            let teePad = scene.childNode(withName: "teePad") as! SKSpriteNode
            let parLabel = scene.childNode(withName: "par") as! SKLabelNode
            let shrubs = scene.childNode(withName: "shrubs")
            let par = Int(parLabel.text!)
            let newHole = Hole(parIn: par!, pinIn: pin, teePadIn: teePad, tileMapIn: tileMap, shrubsIn: shrubs)
            holes.append(newHole)
        }
    }
    
    func calculatePar() -> Int {
        var output = 0
        for hole in holes {
            output += hole.par
        }
        return output
    }
    
    func getHole(holeNum: Int) -> Hole? {
        if (!hasHole(holeIn: holeNum)) {
            return nil
        }
        return holes[holeNum - 1]
    }
    
    func hasHole(holeIn: Int) -> Bool {
        return holeIn <= holes.count
    }
}
