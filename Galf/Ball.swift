//
//  Ball.swift
//  Galf
//
//  Created by Davis Arthur on 1/4/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Ball: SKSpriteNode {
    
    let maxPower = CGFloat(2.0)
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func moving() -> Bool {
        if magnitude(vector: self.physicsBody!.velocity) < CGFloat(0.5) {
            return false
        }
        else {
            return true
        }
    }
    
    func magnitude(vector: CGVector) -> CGFloat {
        return pow(pow(vector.dx, 2.0) + pow(vector.dy, 2.0), 0.5)
    }
    
}
