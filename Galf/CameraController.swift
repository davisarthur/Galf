//
//  CameraController.swift
//  Galf
//
//  Created by Davis Arthur on 6/20/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CameraController: SKNode {

    var up = SKSpriteNode()
    var down = SKSpriteNode()
    var left = SKSpriteNode()
    var right = SKSpriteNode()
    var ballCam = SKCameraNode()
    var controlCam = SKCameraNode()
    var toggleButton = SKLabelNode()
    var returnButton = SKLabelNode()
    var controlling = false
    var direction = -1
    private let moveSpeed = CGFloat(2.0)
    
    init(controlsIn: SKNode, ballCamIn: SKCameraNode, sceneIn: SKScene, tileMapIn: SKTileMapNode) {
        up = controlsIn.childNode(withName: "up") as! SKSpriteNode
        down = controlsIn.childNode(withName: "down") as! SKSpriteNode
        left = controlsIn.childNode(withName: "left") as! SKSpriteNode
        right = controlsIn.childNode(withName: "right") as! SKSpriteNode
        toggleButton = controlsIn.childNode(withName: "toggle") as! SKLabelNode
        returnButton = controlsIn.childNode(withName: "return") as! SKLabelNode
        returnButton.isHidden = true
        ballCam = ballCamIn
        sceneIn.addChild(controlCam)
        super.init()
        genConstraints(tileMapIn: tileMapIn, sceneIn: sceneIn)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func genConstraints(tileMapIn: SKTileMapNode, sceneIn: SKScene) {
        let centerPos = tileMapIn.position
        let size = tileMapIn.mapSize
        let xRange = SKRange(lowerLimit: centerPos.x - size.width / CGFloat(2.0) + sceneIn.size.width / 2.0, upperLimit: centerPos.x + size.width / CGFloat(2.0) - sceneIn.size.width / 2.0)
        let xConstraint = SKConstraint.positionX(xRange)
        let yRange = SKRange(lowerLimit: centerPos.y - size.height / CGFloat(2.0) + sceneIn.size.height / 2.0, upperLimit: centerPos.y + size.height / CGFloat(2.0) - sceneIn.size.height / 2.0)
        let yConstraint = SKConstraint.positionY(yRange)
        controlCam.constraints = [xConstraint, yConstraint]
    }
    
    func prepControlCam() {
        controlCam.position = CGPoint(x: ballCam.position.x, y: ballCam.position.y)
    }
    
    func hideControls() {
        up.isHidden = true
        down.isHidden = true
        left.isHidden = true
        right.isHidden = true
    }
    
    func unhideControls() {
        up.isHidden = false
        down.isHidden = false
        left.isHidden = false
        right.isHidden = false
    }
    
    private func moveChildren(from: SKCameraNode, to: SKCameraNode) {
        for child in from.children {
            child.removeFromParent()
            to.addChild(child)
        }
    }
    
    func restoreBallCam(sceneIn: SKScene) {
        sceneIn.camera = ballCam
        moveChildren(from: controlCam, to: ballCam)
    }
    
    // Is a control touched? If so set the direction of camera movement
    func controlTouched(p: CGPoint, sceneIn: SKScene) -> Bool {
        let pNew = sceneIn.convert(p, to: controlCam)
        if toggleButton.contains(pNew) && !toggleButton.isHidden {
            if up.isHidden {
                unhideControls()
            }
            else {
                hideControls()
            }
            return true
        }
        if returnButton.contains(pNew) && !returnButton.isHidden {
            controlCam.position = CGPoint(x: ballCam.position.x, y: ballCam.position.y)
            returnButton.isHidden = true
            toggleButton.isHidden = false
            return true
        }
        if up.contains(pNew) {
            toggleButton.isHidden = true
            returnButton.isHidden = false
            controlling = true
            sceneIn.camera = controlCam
            moveChildren(from: ballCam, to: controlCam)
            direction = 1
            return true
        }
        if down.contains(pNew) {
            toggleButton.isHidden = true
            returnButton.isHidden = false
            controlling = true
            sceneIn.camera = controlCam
            moveChildren(from: ballCam, to: controlCam)
            direction = 2
            return true
        }
        if left.contains(pNew) {
            toggleButton.isHidden = true
            returnButton.isHidden = false
            controlling = true
            sceneIn.camera = controlCam
            moveChildren(from: ballCam, to: controlCam)
            direction = 3
            return true
        }
        if right.contains(pNew) {
            toggleButton.isHidden = true
            returnButton.isHidden = false
            controlling = true
            sceneIn.camera = controlCam
            moveChildren(from: ballCam, to: controlCam)
            direction = 4
            return true
        }
        return false
    }
    
    
    func moveControlCam() {
        if direction == 1 {
            lookUp()
        }
        if direction == 2 {
            lookDown()
        }
        if direction == 3 {
            lookLeft()
        }
        if direction == 4 {
            lookRight()
        }
    }
    
    func lookUp() {
        controlCam.position.y += moveSpeed
    }
    
    func lookDown() {
        controlCam.position.y -= moveSpeed
    }
    
    func lookLeft() {
        controlCam.position.x -= moveSpeed
    }
    
    func lookRight() {
        controlCam.position.x += moveSpeed
    }
    
    
}
