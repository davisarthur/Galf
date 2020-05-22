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
    
    func changeDirection(isPutting: Bool) {
        aimRight = aimRight ? false : true
        orient(isPutting: isPutting)
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
    
    func orient(isPutting: Bool) {
        if aimRight {
            if isPutting {
                zRotation = CGFloat(Double.pi / 180.0)
                return
            }
            zRotation = CGFloat(Double.pi / 4.0)
        }
        else {
            if isPutting {
                zRotation = CGFloat(179.0 * Double.pi / 180.0)
                return
            }
            zRotation = CGFloat(3.0 * Double.pi / 4.0)
        }
    }
    
    func hide() {
        isHidden = true
    }
    
    func reset(isPutting: Bool) {
        isHidden = false
        zRotation = CGFloat(Double.pi / 4.0)
        aimRight = true
        set = false
        if isPutting {
            zRotation = CGFloat(Double.pi / 180.0)
            set = true
        }
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
