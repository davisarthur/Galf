//
//  Bounds.swift
//  Galf
//
//  Created by Davis Arthur on 1/12/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct Bounds {
    
    let left: SKShapeNode
    let top: SKShapeNode
    let right: SKShapeNode
    let bot: SKShapeNode
    let borderWidth = CGFloat(5.0)
    
    init(map: SKTileMapNode) {
        
        let size = map.mapSize
        let center = map.position
        
        let leftEdge = center.x - size.width / 2.0 - borderWidth / 2.0
        let leftRect = CGRect(x: leftEdge, y: center.y, width: borderWidth, height: size.height)
        left = SKShapeNode(rect: leftRect)
        
        let rightEdge = center.x + size.width / 2.0 + borderWidth / 2.0
        let rightRect = CGRect(x: rightEdge, y: center.y, width: borderWidth, height: size.height)
        right = SKShapeNode(rect: rightRect)
        
        let topEdge = center.y + size.height / 2.0 + borderWidth / 2.0
        let topRect = CGRect(x: center.x, y: topEdge, width: size.width, height: borderWidth)
        top = SKShapeNode(rect: topRect)
        
        let botEdge = center.y - size.height / 2.0 - borderWidth / 2.0
        let botRect = CGRect(x: center.x, y: botEdge, width: size.width, height: borderWidth)
        bot = SKShapeNode(rect: botRect)
    }
}
