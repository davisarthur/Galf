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
    private var sky : SKSpriteNode!
    private var powerMeter : SKSpriteNode!
    private var pointer : Pointer!
    private var arrow : Arrow!
    private var cam : SKCameraNode!
    private var pin: SKSpriteNode!
    private var teePad: SKSpriteNode!
    private var course: BallardLinks = BallardLinks()
    private var hole : Hole!
    private var ui : UI!
    private var currentHole = 0
    
    override func didMove(to view: SKView) {
        
        // Initialize UI and basic features
        self.sky = self.childNode(withName: "//sky") as! SKSpriteNode?
        self.pointer = self.childNode(withName: "//pointer") as! Pointer?
        self.powerMeter = self.childNode(withName: "//powerMeter") as! SKSpriteNode?
        self.arrow = self.childNode(withName: "//arrow") as! Arrow?
        self.ball = self.childNode(withName: "//Ball") as! Ball?
        self.switchButton = self.childNode(withName: "//SwitchButton") as! SKSpriteNode?
        self.cam = self.childNode(withName: "cam") as! SKCameraNode?
        self.camera = cam
        self.ui = self.childNode(withName: "//UI") as! UI?
        ui.setUp()
        ui.updatePlayer(playerName: "Dave Dog")
        
        // Initialize first hole
        loadNextHole()
    }
    
    func loadNextHole() {
        currentHole += 1
        
        let newHole = course.nextHole()
        self.hole = newHole
        ui.loadHole(num: currentHole, holeIn: self.hole)
        
        self.tileMap = newHole.tileMap
        tileMap.removeFromParent()
        self.addChild(tileMap)
        
        self.pin = newHole.pin
        pin.removeFromParent()
        self.addChild(pin)
        
        self.teePad = newHole.teePad
        teePad.removeFromParent()
        self.addChild(teePad)
        self.camera?.constraints = BallCam.genBounds(ballMap: self.tileMap, scene: self, ball: self.ball)
            
        TerrainBuilder.createFromMap(tileMap: tileMap, pin: pin, scene: self)
        
        ball.position = teePad.position
        ball.position.x -= 5.0
        ball.position.y += 20.0
    }
    
    func deleteLastHole() {
        ui.updateScore()
        self.hole = nil
        for child in self.children {
            if child.name == nil {
                child.removeFromParent()
            }
        }
        tileMap.removeFromParent()
        pin.removeFromParent()
        teePad.removeFromParent()
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
            if (course.hasNextHole()) {
                deleteLastHole()
                loadNextHole()
            }
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
        ui.addStroke()
        arrow.hide()
        pointer.hide()
        switchButton.isHidden = true
        powerMeter.isHidden = true
        let angle = CGFloat(arrow.zRotation)
        let power = ball.maxPower * powFrac
        ball.physicsBody!.isDynamic = true
        ball.physicsBody!.applyImpulse(CGVector(dx: power * cos(angle), dy: power * sin(angle)))
    }
    
    func prep() {
        ball.physicsBody!.isDynamic = false
        ball.zRotation = CGFloat(0.0)
        switchButton.isHidden = false
        powerMeter.isHidden = false
        arrow.reset()
        pointer.reset()
    }

    func withinSwitch(touch: CGPoint) -> Bool {
        let adjustedTouch = CGPoint(x: touch.x - cam.position.x, y: touch.y - cam.position.y)
        let buttonRect = switchButton?.calculateAccumulatedFrame()
        return (buttonRect?.contains(adjustedTouch))!
    }
    
}
