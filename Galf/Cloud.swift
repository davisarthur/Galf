//
//  Cloud.swift
//  Galf
//
//  Created by Davis Arthur on 6/16/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Cloud: SKSpriteNode {
    
    var velocity: CGFloat = 0.0
    var tileMap: SKTileMapNode = SKTileMapNode()
    
    // Custom initializer with tilemap
    init(velocityIn: CGFloat, cloudsIn: [Cloud], tileMapIn: SKTileMapNode) {
        let texture = SKTexture(imageNamed: "cloud\(Int.random(in: 0...1))")
        super.init(texture: texture, color: UIColor.white, size: texture.size())
        self.xScale = CGFloat.random(in: 0.2...0.3)
        self.yScale = CGFloat.random(in: 0.2...0.3)
        self.zPosition = -20.0
        self.tileMap = tileMapIn
        tileMap.addChild(self)
        setPostion(clouds: cloudsIn)
        velocity = velocityIn
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    // Set the position of the cloud so it is not touching another cloud
    func setPostion(clouds: [Cloud]) {
        while true {
            let xRange = -tileMap.mapSize.width / 2.0...tileMap.mapSize.width / 2.0
            let x = CGFloat.random(in: xRange)
            let yRange = -tileMap.mapSize.height / 2.0...tileMap.mapSize.height / 2.0
            let y = CGFloat.random(in: yRange)
            self.position = CGPoint(x: x, y: y)
            if touching(clouds: clouds) {
                continue
            }
            if (!validTile()) {
                continue
            }
            break
        }
    }
    
    // See if the cloud is touching any other clouds in the scene
    func touching(clouds: [Cloud]) -> Bool {
        for cloud in clouds {
            if self.intersects(cloud) {
                return true
            }
        }
        return false
    }
    
    // See if the cloud is on the tileMap
    func onMap() -> Bool {
        if self.position.x > tileMap.mapSize.width / 2.0 {
            return false
        }
        if self.position.x < -tileMap.mapSize.width / 2.0 {
            return false
        }
        return true
    }
    
    // See if the cloud is on an empty tile
    func validTile() -> Bool {
        let tileDef = tileMap.tileDefinition(atColumn: tileMap.tileColumnIndex(fromPosition: self.position), row: tileMap.tileRowIndex(fromPosition: self.position))
        if (tileDef == nil) {
            return true
        }
        return false
    }
    
    func move() {
        self.position.x += self.velocity
        if !self.onMap() {
            self.position.x = -tileMap.mapSize.width / 2.0
        }
    }
}
