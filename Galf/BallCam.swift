//
//  BallCam.swift
//  Galf
//
//  Created by Davis Arthur on 1/12/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class BallCam : SKCameraNode {
    
    let boundaries: Bounds?
    let ball: Ball?
    let delta = CGFloat(1.0)
    
    init(boundsIn: Bounds, ballIn: Ball) {
        ball = ballIn
        boundaries = boundsIn
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        boundaries = nil
        ball = nil
       super.init(coder: aDecoder)
    }
    
    func autoMove() {
        if contains(boundaries!.left) {
            while(contains(boundaries!.left)) {
                moveRight()
            }
        }
        else if contains(boundaries!.right) {
            while(contains(boundaries!.right)) {
                moveLeft()
            }
        }
        else if contains(boundaries!.top) {
            while(contains(boundaries!.top)) {
                moveDown()
            }
        }
        else if contains(boundaries!.bot) {
            while(contains(boundaries!.bot)) {
                moveUp()
            }
        }
        else {
            position = ball!.position
        }
    }
    
    func moveLeft() {
        position.x = position.x - delta
    }
    
    func moveRight() {
        position.x = position.x + delta
    }
    
    func moveUp() {
        position.y = position.y + delta
    }
    
    func moveDown() {
        position.y = position.y - delta
    }
    
}
