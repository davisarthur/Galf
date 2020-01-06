//
//  Arrow.swift
//  Galf
//
//  Created by Davis Arthur on 1/2/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Arrow: SKSpriteNode {
    
    var delta = CGFloat(Double.pi / 180)
    var aimRight = true
    var set = false
    var min = CGFloat(0.0)
    var max = CGFloat(Double.pi / 2.0)
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setAngle() {
        set = true
    }
    
    func changeDirection() {
        aimRight = aimRight ? false : true
        orient()
        updateMinMax()
    }
    
    func updateMinMax() {
        if aimRight {
            min = CGFloat(0.0)
            max = CGFloat(Double.pi / 2.0)
        }
        else {
            min = CGFloat(Double.pi / 2.0)
            max = CGFloat(Double.pi)
        }
    }
    
    func orient() {
        if aimRight {
            zRotation = CGFloat(Double.pi / 4.0)
        }
        else {
            zRotation = CGFloat(3.0 * Double.pi / 4.0)
        }
    }
    
    func hide() {
        isHidden = true
    }
    
    func reset() {
        isHidden = false
        zRotation = CGFloat(Double.pi / 4.0)
        aimRight = true
        set = false
        min = CGFloat(0.0)
        max = CGFloat(Double.pi / 2.0)
    }
    
    func rotate() {
        if self.zRotation >= min && self.zRotation <= max {
            zRotation += delta
        }
        else {
            delta *= -1
            while zRotation < min || zRotation > max {
                zRotation += delta
            }
        }
    }
}
