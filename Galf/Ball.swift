//
//  Ball.swift
//  Galf
//
//  Created by Davis Arthur on 1/4/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Ball: SKSpriteNode {
    
    let maxPower = CGFloat(2000.0)
    var hasHitGround = false
    var prevPos: CGPoint? = nil
    var penalty = false
    var putting = false
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func moving() -> Bool {
        var output = false
        if magnitude(vector: self.physicsBody!.velocity) > CGFloat(0.1) {
            return true
        }
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run {
            if self.magnitude(vector: self.physicsBody!.velocity) < CGFloat(0.1) {
                output = false
            }
            else {
                output = true
            }
            }])
        self.run(sequence)
        return output
        
    }
    
    func magnitude(vector: CGVector) -> CGFloat {
        return pow(pow(vector.dx, 2.0) + pow(vector.dy, 2.0), 0.5)
    }
    
    func terrainEffect(tileNameIn: String?, ui: inout UI) {
        if (tileNameIn == nil) {
            return
        }
        if (tileNameIn?.contains("R"))! {
            roughEffect()
            return
        }
        if (tileNameIn?.contains("B"))! {
            bunkerEffect()
            return
        }
        if (tileNameIn?.contains("W"))! {
            penalty = true
            return
        }
    }
    
    func updatePhysics(tileNameIn: String?) {
        if (tileNameIn == nil) {
            defaultPhysics()
            return
        }
        if (tileNameIn?.contains("R"))! {
            roughPhysics()
            putting = false
            return
        }
        if (tileNameIn?.contains("B"))! {
            bunkerPhysics()
            putting = false
            return
        }
        if (tileNameIn?.contains("F"))! {
            putting = false
            return
        }
        if (tileNameIn?.contains("G"))! {
            putting = true
            return
        }
        if (tileNameIn?.contains("W"))! {
            penalty = true
            putting = false
            return
        }
    }

    private func roughEffect() {
        self.physicsBody?.applyImpulse(CGVector(dx: -(self.physicsBody?.velocity.dx)! * 0.5, dy: -(self.physicsBody?.velocity.dy)! * 0.5))
    }
    
    private func bunkerEffect() {
        self.physicsBody?.applyImpulse(CGVector(dx: -(self.physicsBody?.velocity.dx)! * 0.9, dy: -(self.physicsBody?.velocity.dy)! * 0.9))
    }
    
    func penalty(uiIn: inout UI) {
        if (prevPos == nil) {
            return
        }
        self.physicsBody?.isDynamic = false
        self.position = self.prevPos!
        self.physicsBody?.isDynamic = true
        uiIn.addStroke()
    }
    
    func defaultPhysics() {
        self.physicsBody?.restitution = 0.3
        self.physicsBody?.linearDamping = 0.5
        self.physicsBody?.angularDamping = 0.75
    }
    
    private func roughPhysics() {
        self.physicsBody?.restitution = 0.2
        self.physicsBody?.angularDamping = 7.0
    }
    
    private func bunkerPhysics() {
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.angularDamping = 50.0
    }
    
    func outOfBounds(mapIn: SKTileMapNode) {
        if !(mapIn.contains(self.position)) {
            self.penalty = true
        }
    }
    
}
