//
//  BallCam.swift
//  Galf
//
//  Created by Davis Arthur on 1/12/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct BallCam {
    
    let delta = CGFloat(1.0)
    
    static func genBounds(ballMap: SKTileMapNode, scene: SKScene, ball: Ball) -> [SKConstraint] {
        let centerPos = ballMap.position
        let size = ballMap.mapSize
        let xRange = SKRange(lowerLimit: centerPos.x - size.width / CGFloat(2.0) + scene.size.width / 2.0, upperLimit: centerPos.x + size.width / CGFloat(2.0) - scene.size.width / 2.0)
        let xConstraint = SKConstraint.positionX(xRange)
        let yRange = SKRange(lowerLimit: centerPos.y - size.height / CGFloat(2.0) + scene.size.height / 2.0, upperLimit: centerPos.y + size.height / CGFloat(2.0) - scene.size.height / 2.0)
        let yConstraint = SKConstraint.positionY(yRange)
        let zeroRange = SKRange(constantValue: CGFloat(0.0))
        let ballConstraint = SKConstraint.distance(zeroRange, to: ball)
        return [ballConstraint, xConstraint, yConstraint]
    }
    
}
