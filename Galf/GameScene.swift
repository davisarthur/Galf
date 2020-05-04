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
    private var cam : SKCameraNode!
    private var pin: SKSpriteNode!
    private var teePad: SKSpriteNode!
    private var course = GreenerPastures()
    private var hole : Hole!
    
    override func didMove(to view: SKView) {
        
        // Initialize UI
        self.pointer = self.childNode(withName: "//pointer") as! Pointer?
        self.arrow = self.childNode(withName: "//arrow") as! Arrow?
        self.ball = self.childNode(withName: "//Ball") as! Ball?
        self.switchButton = self.childNode(withName: "//SwitchButton") as! SKSpriteNode?
        self.cam = self.childNode(withName: "cam") as! SKCameraNode?
        self.camera = cam
        
        // Initialize hole
        self.tileMap = self.childNode(withName: "//TileMap") as! SKTileMapNode?
        self.pin = self.childNode(withName: "pin") as! SKSpriteNode?
        self.teePad = self.childNode(withName: "teePad") as! SKSpriteNode?
        loadNextHole()
    }
    
    func loadNextHole() {
        let newHole = course.nextHole()
        self.hole = newHole
        self.tileMap = newHole.tileMap
        self.pin = newHole.pin
        self.teePad = newHole.teePad
        self.camera?.constraints = BallCam.genBounds(ballMap: self.tileMap, scene: self, ball: self.ball)
            
        TerrainBuilder.createFromMap(tileMap: tileMap, pin: pin, scene: self)
        
        ball.position = teePad.position
        ball.position.x -= 5.0
        ball.position.y += 20.0
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
        if (hole.inCup(ballPos: ball.position)) {
            ball.position = teePad.position
            ball.position.y += 20.0
            ball.physicsBody?.velocity = CGVector(dx: 0.0, dy: -1.0)
        }
        
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
        let adjustedTouch = CGPoint(x: touch.x - cam.position.x, y: touch.y - cam.position.y)
        let buttonRect = switchButton?.calculateAccumulatedFrame()
        return (buttonRect?.contains(adjustedTouch))!
    }
    
}
