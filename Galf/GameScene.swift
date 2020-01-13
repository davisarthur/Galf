//
//  GameScene.swift
//  Galf
//
//  Created by Davis Arthur on 12/18/19.
//  Copyright © 2019 Davis Arthur. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var tileMap : SKTileMapNode! // terrain
    private var switchButton : SKSpriteNode!
    private var ball : Ball!
    private var points : [CGPoint] = []
    private var pointer : Pointer!
    private var arrow : Arrow!
    private var cam : BallCam!
    
    override func didMove(to view: SKView) {
        
        // Initialize pointer, arrow, and tile map
        self.pointer = self.childNode(withName: "//pointer") as! Pointer?
        self.arrow = self.childNode(withName: "//arrow") as! Arrow?
        self.ball = self.childNode(withName: "//Ball") as! Ball?
        self.tileMap = self.childNode(withName: "//TileMap") as! SKTileMapNode?
        self.switchButton = self.childNode(withName: "//SwitchButton") as! SKSpriteNode?
        self.cam = BallCam(boundsIn: Bounds(map: tileMap), ballIn: ball)
        
        self.camera = cam
        TerrainBuilder.createFromMap(tileMap: tileMap, scene: self)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if ((ball?.physicsBody!.isDynamic)!) {
            
        }
        else {
            if withinSwitch(touch: pos) {
                if !(arrow.set) {
                    arrow.changeDirection()
                }
                print("Within switch")
            }
            else {
                if !(arrow.set) {
                    arrow.setAngle()
                }
                else if !(pointer.set) {
                    let fraction = pointer.setPower()
                    launchBall(powFrac: fraction)
                }
                print("Outside button")
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        cam.autoMove()
        
        if !(ball.moving()) {
            if ball.physicsBody!.isDynamic {
                SKAction.wait(forDuration: 1.0)
                if !(ball.moving()) {
                    prep()
                }
            }
            else if !(arrow.set) {
                arrow.rotate()
            }
            else if !(pointer.set) {
                pointer.move()
            }
        }
    }
    
    func launchBall(powFrac: CGFloat) {
        arrow.isHidden = true
        let angle = CGFloat(arrow.zRotation)
        let power = ball.maxPower * powFrac
        ball.physicsBody!.isDynamic = true
        ball.physicsBody!.applyImpulse(CGVector(dx: power * cos(angle), dy: power * sin(angle)))
    }
    
    func prep() {
        ball.physicsBody!.isDynamic = false
        ball.zRotation = CGFloat(0.0)
        arrow.reset()
        pointer.reset()
    }

    func withinSwitch(touch: CGPoint) -> Bool {
        let buttonRect = switchButton?.calculateAccumulatedFrame()
        return (buttonRect?.contains(touch))!
    }
    
}
