//
//  GameScene.swift
//  Galf
//
//  Created by Davis Arthur on 12/18/19.
//  Copyright © 2019 Davis Arthur. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var tileMap : SKTileMapNode!
    private var switchButton : SKSpriteNode!
    private var ball : Ball!
    private var powerMeter : SKSpriteNode!
    private var pointer : Pointer!
    private var arrow : Arrow!
    private var cam : SKCameraNode!
    private var pin: SKSpriteNode!
    private var teePad: SKSpriteNode!
    private var hole : Hole?
    private var ui : UI!
    private var builder: TerrainBuilder!
    private var handler: GameHandler!
    
    override func didMove(to view: SKView) {
        
        // Initialize UI and basic features
        self.physicsWorld.contactDelegate = self
        self.pointer = self.childNode(withName: "//pointer") as! Pointer?
        self.powerMeter = self.childNode(withName: "//powerMeter") as! SKSpriteNode?
        self.arrow = self.childNode(withName: "//arrow") as! Arrow?
        self.switchButton = self.childNode(withName: "//SwitchButton") as! SKSpriteNode?
    }
    
    func loadHole(gameHandler: GameHandler) {
        
        self.hole = gameHandler.getNextHole()
        self.ui = self.childNode(withName: "cam")?.childNode(withName: "ui") as! UI?
        
        self.handler = gameHandler
        ui.setUp(handlerIn: self.handler)
        
        self.tileMap = self.hole?.tileMap
        tileMap.removeFromParent()
        self.addChild(tileMap)
        
        self.pin = self.hole?.pin
        pin.removeFromParent()
        self.addChild(pin)
        
        self.teePad = self.hole?.teePad
        teePad.removeFromParent()
        self.addChild(teePad)
        
        self.ball = self.childNode(withName: "//Ball") as! Ball?
        ball.physicsBody?.categoryBitMask = 1
        self.cam = self.childNode(withName: "cam") as! SKCameraNode?
        self.camera = cam
        self.camera?.constraints = BallCam.genBounds(ballMap: self.tileMap, scene: self, ball: self.ball)
            
        builder = TerrainBuilder(mapIn: tileMap, pinIn: pin, sceneIn: self)
        builder.build()
        
        for child in self.children {
            if (child.name == nil) {
                child.physicsBody?.contactTestBitMask = ball.physicsBody?.contactTestBitMask as! UInt32
                child.physicsBody?.collisionBitMask = ball.physicsBody?.collisionBitMask as! UInt32
                child.physicsBody?.categoryBitMask = 2
            }
        }
        
        ball.position = teePad.position
        ball.position.x -= 5.0
        ball.position.y += 20.0
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if ((ball?.physicsBody!.isDynamic)!) {
            
        }
        else {
            if withinSwitch(touch: pos) {
                if !(arrow.set) || ball.putting {
                    arrow.changeDirection(isPutting: ball.putting)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // hole has not been set up, do nothing
        if (hole == nil) {
            return
        }
        
        // if the ball is in the cup, load the scorecard
        if (hole!.inCup(ballPos: ball.position)) {
            self.handler.players[0].scores.append(Int(ui.lieLabel.text!)!)
            handler.updateTotalScore()
            loadScorecard()
            return
        }
        
        // Check if the ball is out of bounds
        ball.outOfBounds(mapIn: tileMap)
        
        // if there was a penalty move the ball to previous position
        if (ball.penalty) {
            ball.penalty(uiIn: &ui)
            ball.penalty = false
        }
        
        // If the ball is not moving
        if !(ball.moving()) {
            ball.hasHitGround = false
            ball.defaultPhysics()
            if ball.physicsBody!.isDynamic {
                SKAction.wait(forDuration: 1.0)
                if !(ball.moving()) {
                    prep()
                }
            }
            else if !(arrow.set) && !ball.putting {
                arrow.rotate()
            }
            else if !(pointer.set) {
                pointer.move()
            }
            return
        }
        
        if (ball.hasHitGround) {
            let ballRow = tileMap.tileRowIndex(fromPosition: ball.position)
            let ballCol = tileMap.tileColumnIndex(fromPosition: ball.position)
            let ballTileDef = tileMap.tileDefinition(atColumn: ballCol, row: ballRow)
            ball.updatePhysics(tileNameIn: ballTileDef?.name)
        }
        
    }
    
    func launchBall(powFrac: CGFloat) {
        ui.addStroke()
        ball.prevPos = ball.position
        arrow.hide()
        pointer.hide()
        switchButton.isHidden = true
        powerMeter.isHidden = true
        let angle = CGFloat(arrow.zRotation)
        var power = ball.maxPower * powFrac
        if ball.putting {
            power /= 10.0
        }
        ball.physicsBody!.isDynamic = true
        ball.physicsBody!.applyImpulse(CGVector(dx: power * cos(angle), dy: power * sin(angle)))
    }
    
    func prep() {
        ball.physicsBody!.isDynamic = false
        ball.zRotation = CGFloat(0.0)
        switchButton.isHidden = false
        powerMeter.isHidden = false
        arrow.reset(isPutting: ball.putting)
        pointer.reset()
    }

    func withinSwitch(touch: CGPoint) -> Bool {
        let adjustedTouch = CGPoint(x: touch.x - ball.position.x, y: touch.y - ball.position.y)
        let buttonRect = switchButton?.calculateAccumulatedFrame()
        return (buttonRect?.contains(adjustedTouch))!
    }
    
    func loadScorecard() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = Scorecard(fileNamed: "Scorecard") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }
        
        scene.setHandler(handlerIn: handler)
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let ballRow = tileMap.tileRowIndex(fromPosition: ball.position)
        let ballCol = tileMap.tileColumnIndex(fromPosition: ball.position)
        let ballTileDef = tileMap.tileDefinition(atColumn: ballCol, row: ballRow)
        ball.terrainEffect(tileNameIn: ballTileDef?.name, ui: &ui)
        ball.hasHitGround = true
    }
    
}
