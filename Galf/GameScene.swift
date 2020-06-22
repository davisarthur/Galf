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
    private var ballCam : SKCameraNode!
    private var pin: SKSpriteNode!
    private var teePad: SKSpriteNode!
    private var hole : Hole?
    private var ui : UI!
    private var builder: TerrainBuilder!
    private var handler: GameHandler!
    private var playerSprite: SKSpriteNode!
    private var puttingAnimation: SKAction!
    private var swingAnimation: SKAction!
    private var cloudCount = 4
    private var cloudSpeed = CGFloat(0.5)
    private var clouds = [Cloud]()
    private var camControl: CameraController!
    
    override func didMove(to view: SKView) {
        
        // Initialize the putting and swing animations
        var puttingTextures = [SKTexture]()
        for i in 0...5 {
            puttingTextures.append(SKTexture(imageNamed: "putting\(i)"))
        }
        puttingAnimation = SKAction.animate(with: puttingTextures, timePerFrame: 0.1)
        
        var swingTextures = [SKTexture]()
        for i in 0...10 {
            swingTextures.append(SKTexture(imageNamed: "swing\(i)"))
        }
        swingTextures.append(SKTexture(imageNamed: "swing10"))
        swingTextures.append(SKTexture(imageNamed: "swing10"))
        swingTextures.append(SKTexture(imageNamed: "swing10"))
        swingTextures.append(SKTexture(imageNamed: "swing10"))
        swingTextures.append(SKTexture(imageNamed: "swing10"))
        swingAnimation = SKAction.animate(with: swingTextures, timePerFrame: 0.08)
        
        // Initialize clouds
        while clouds.count < cloudCount {
            genCloud()
        }
        
        // Initialize UI and basic features
        self.physicsWorld.contactDelegate = self
        self.pointer = self.childNode(withName: "//pointer") as! Pointer?
        self.powerMeter = self.childNode(withName: "//powerMeter") as! SKSpriteNode?
        self.arrow = self.childNode(withName: "//arrow") as! Arrow?
        self.switchButton = self.childNode(withName: "//SwitchButton") as! SKSpriteNode?
    }
    
    private func genCloud() {
        clouds.append(Cloud(velocityIn: cloudSpeed, cloudsIn: clouds, tileMapIn: tileMap))
    }
    
    func loadHole(gameHandler: GameHandler) {
        
        self.hole = gameHandler.getNextHole()
        
        for shrub in self.hole!.shrubs!.children {
            shrub.removeFromParent()
            self.addChild(shrub)
        }
        
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
        
        // initize ball camera and secondary camera
        self.ballCam = self.childNode(withName: "cam") as! SKCameraNode?
        self.camera = ballCam
        self.camera?.constraints = BallCam.genBounds(ballMap: self.tileMap, scene: self, ball: self.ball)
        self.camControl = CameraController(controlsIn: ballCam.childNode(withName: "controls")!, ballCamIn: ballCam, sceneIn: self, tileMapIn: tileMap)
        camControl.prepControlCam()
        
        // build terrain
        builder = TerrainBuilder(mapIn: tileMap, pinIn: pin, sceneIn: self)
        builder.build()
        
        // collision configuration
        for child in self.children {
            if (child.name == nil) {
                child.physicsBody?.contactTestBitMask = ball.physicsBody?.contactTestBitMask as! UInt32
                child.physicsBody?.collisionBitMask = ball.physicsBody?.collisionBitMask as! UInt32
                child.physicsBody?.categoryBitMask = 2
            }
        }
        
        // Move ball to tee pad
        ball.position = teePad.position
        ball.position.x -= 5.0
        ball.position.y += 20.0
        
        // add player to the scene
        playerSprite = SKSpriteNode(imageNamed: "putting0")
        playerSprite.size = CGSize(width: playerSprite.size.width / 8.0, height: playerSprite.size.height / 8.0)
        playerSprite.isHidden = true
        addChild(playerSprite)
        positionPlayer()
    }
    
    private func positionPlayer() {
        playerSprite.position = ball.position
        playerSprite.zPosition = -1.0
        playerSprite.position.x -= 3.0 * playerSprite.size.width / 64.0 * playerSprite.xScale
        playerSprite.position.y += 12.0 * playerSprite.size.height / 64.0
    }
    
    func touchDown(atPoint pos : CGPoint) {
        // if the ball is not dynamic...
        if (!(ball?.physicsBody!.isDynamic)!) {
            if withinSwitch(touch: pos) {
                if !(arrow.set) || ball.putting {
                    arrow.changeDirection(isPutting: ball.putting)
                    playerSprite.xScale *= -1.0
                }
                print("Within switch")
            }
            else {
                if !(arrow.set) {
                    // if a control is touched...
                    if (camControl.controlTouched(p: pos, sceneIn: self)) {
                        return
                    }
                    else {
                        camControl.hideControls()
                        camControl.restoreBallCam(sceneIn: self)
                        arrow.setAngle()
                    }
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            camControl.controlling = false
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // move clouds
        for i in 0...clouds.count - 1 {
            clouds[i].move()
        }
        
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
        
        if camControl.controlling {
            camControl.moveControlCam()
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
            playerSprite.isHidden = false
            if ball.putting {
                playerSprite.texture = SKTexture(imageNamed: "putting0")
            }
            else {
                playerSprite.texture = SKTexture(imageNamed: "swing0")
            }
            
            positionPlayer()
            ball.hasHitGround = false
            ball.defaultPhysics()
            
            if ball.physicsBody!.isDynamic {
                prep()
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
            playerSprite.run(puttingAnimation)
            let sequence = SKAction.sequence([SKAction.wait(forDuration: 0.4), SKAction.run {
                self.ball.physicsBody!.isDynamic = true
                self.ball.physicsBody!.applyImpulse(CGVector(dx: power * cos(angle), dy: power * sin(angle)))
                }])
            playerSprite.run(sequence)
        }
        else {
            playerSprite.run(swingAnimation)
            let sequence = SKAction.sequence([SKAction.wait(forDuration: 0.56), SKAction.run {
                self.ball.physicsBody!.isDynamic = true
                self.ball.physicsBody!.applyImpulse(CGVector(dx: power * cos(angle), dy: power * sin(angle)))
                }])
            playerSprite.run(sequence)
        }
        
    }
    
    func prep() {
        camControl.restoreBallCam(sceneIn: self)
        camControl.prepControlCam()
        camControl.returnButton.isHidden = true
        camControl.toggleButton.isHidden = false
        camControl.unhideControls()
        ball.physicsBody!.isDynamic = false
        ball.zRotation = CGFloat(0.0)
        switchButton.isHidden = false
        powerMeter.isHidden = false
        arrow.reset(isPutting: ball.putting)
        playerSprite.xScale = 1.0
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
