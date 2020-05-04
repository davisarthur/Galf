//
//  Hole.swift
//  Galf
//
//  Created by Davis Arthur on 3/20/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Hole {
    
    let par: Int
    let length: CGFloat
    let pin: SKSpriteNode
    let teePad: SKSpriteNode
    let tileMap: SKTileMapNode
    
    init(parIn: Int, pinIn: SKSpriteNode, teePadIn: SKSpriteNode, tileMapIn: SKTileMapNode) {
        par = parIn
        pin = pinIn
        teePad = teePadIn
        length = pow(pow(teePad.position.x - pin.position.x, 2.0) + pow(teePad.position.y - (pin.position.y - pin.size.height / 2.0), 2.0), 0.5)
        tileMap = tileMapIn
    }
    
    func inCup(ballPos: CGPoint) -> Bool {
        let leftCup = CGPoint(x: pin.position.x - 7.0, y: pin.position.y - pin.size.height / 2)
        let leftCupBot = CGPoint(x: pin.position.x - 7.0, y: pin.position.y - pin.size.height / 2 - 12.0)
        let rightCup = CGPoint(x: pin.position.x + 7.0, y: pin.position.y - pin.size.height / 2)
        if ((ballPos.x > leftCup.x && ballPos.x < rightCup.x) && (ballPos.y > leftCupBot.y && ballPos.y < leftCup.y)) {
            return true
        }
        return false
    }
    
}
