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
    
    override func didMove(to view: SKView) {
        
        // Initialize pointer, arrow, and tile map
        self.pointer = self.childNode(withName: "//pointer") as! Pointer?
        self.arrow = self.childNode(withName: "//arrow") as! Arrow?
        self.ball = self.childNode(withName: "//Ball") as! Ball?
        self.tileMap = self.childNode(withName: "//TileMap") as! SKTileMapNode?
        self.switchButton = self.childNode(withName: "//SwitchButton") as! SKSpriteNode?
        
        createTerrainPoints()
        
        // Create ground
        let ground = SKShapeNode(splinePoints: &points, count: points.count)
        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0.5
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)
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
    
    func createTerrainPoints() {
        // Create tile map
        for col in 0...tileMap!.numberOfColumns - 1 {
            for ro in stride(from: tileMap!.numberOfRows - 1, to: 0, by: -1) {
                var def = tileMap?.tileDefinition(atColumn: col, row: ro)?.name
                if def != nil {
                    var incomplete = false
                    var usingBuffer = false
                    var newPoints : [CGPoint] = []
                    var bufferPoints : [CGPoint] = []
                    var ro1 = ro
                    var xBefore = CGFloat(0.0)
                    if points.count > 0 {
                        xBefore = points[points.count - 1].x
                    }
                    else {
                        xBefore = ((tileMap?.centerOfTile(atColumn: col, row: ro).x)! - 16.0)
                    }
                    while true {
                        if def == "Top" {
                            newPoints = TerrainBuilder.createTop(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making Top")
                            }
                        else if def == "TopRight" {
                            newPoints = TerrainBuilder.createTopRight(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making TopRight")
                            }
                        else if def == "BotLeftSlant" {
                            newPoints = TerrainBuilder.createBotLeftSlant(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making BotLeftSlant")
                            }
                        else if def == "LeftCurved" {
                            newPoints = TerrainBuilder.createLeftCurved(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making LeftCurved")
                        }
                        else if def == "TopLeftSlant" {
                            newPoints = TerrainBuilder.createTopLeftSlant(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making TopLeftSlant")
                        }
                        else if def == "TopLeft" {
                            newPoints = TerrainBuilder.createTopLeft(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making TopLeft")
                        }
                        else if def == "RightCurved" {
                            newPoints = TerrainBuilder.createRightCurved(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making RightCurved")
                        }
                        else if def == "TopRightSlant" {
                            newPoints = TerrainBuilder.createTopRightSlant(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making TopRightSlant")
                        }
                        else if def == "BotRightSlant" {
                            newPoints = TerrainBuilder.createBotRightSlant(center: (tileMap?.centerOfTile(atColumn: col, row: ro1))!)
                            print("Making BotRightSlant")
                        }
                        else {
                            print("Atypical terrain tile. Definition: \(String(describing: def))")
                        }
                        
                        print(newPoints)
                        
                        // If the points array is empty, the first tile must be added.
                        if points.count == 0 {
                            points += Array(newPoints[0...newPoints.count - 1])
                            print("added newPoints")
                            }
                        // Otherwise...
                        else {
                            // If the leftmost point in newPoints matches the rightmost point in points, append newPoints
                            if points[points.count - 1] == newPoints[0] {
                                points += Array(newPoints[1...newPoints.count - 1])
                                print("added newPoints")
                                // Append bufferPoints after appending newPoints
                                if bufferPoints.count > 0 {
                                    // provided bufferPoints and points are continuous
                                    if points[points.count - 1] == bufferPoints[0] {
                                        points += Array(bufferPoints[1...bufferPoints.count - 1])
                                        bufferPoints = []
                                        }
                                    else {
                                        print("Invalid buffer")
                                        }
                                    break
                                    }
                                }
                            else {
                                bufferPoints = newPoints
                                print("placing in buffer")
                                usingBuffer = true
                            }
                        }
                        incomplete = !usingBuffer && points[points.count - 1].x - xBefore != 32.0
                        
                        if incomplete || usingBuffer {
                            ro1 -= 1
                            def = self.tileMap?.tileDefinition(atColumn: col, row: ro1)?.name
                            continue
                            }
                        else {
                            break
                        }
                    }
                    break
                }
            }
        }
    }

}
