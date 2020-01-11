//
//  Rough.swift
//  Galf
//
//  Created by Davis Arthur on 1/11/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Rough: SKShapeNode {
    
    let rest = CGFloat(0.4)
    let width = CGFloat(5.0)
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func settings() {
        lineWidth = width
        physicsBody = SKPhysicsBody(edgeChainFrom: path!)
        physicsBody?.restitution = rest
        physicsBody?.isDynamic = false
    }
}
