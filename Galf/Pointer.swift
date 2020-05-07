//
//  Pointer.swift
//  Galf
//
//  Created by Davis Arthur on 1/4/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Pointer: SKSpriteNode {
    
    let min = CGFloat(-12.0)
    let max = CGFloat(12.0)
    
    var set = false
    var delta = CGFloat(0.5)
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setPower() -> CGFloat {
        set = true
        let power = (position.y + CGFloat(12.0)) / CGFloat(24.0)
        print("Power: \(power)")
        return power
    }
    
    func hide() {
        isHidden = true
    }
    
    func move() {
         if position.y >= min && position.y <= max {
             position.y += delta
             }
         else {
             delta *= -1
             while position.y < min || position.y > max {
                 position.y += delta
             }
         }
     }
    
    func reset() {
        isHidden = false
        set = false
        position.y = min
    }
    
    
}
