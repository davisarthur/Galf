//
//  SNButton.swift
//  Galf
//
//  Created by Davis Arthur on 5/2/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class SNButton: SKLabelNode {
    
    // buttons are initialized to off position
    var on = false
    
    // required initializer
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    // Turn the button on or off
    // Returns false if the button was not pushed, otherwise true
    func push(touchIn: CGPoint) -> Bool {
        if (!contains(touchIn)) {
            return false
        }
        if (on) {
            on = false
            return true
        }
        on = true
        return true
    }
    
    // Is the button on?
    func getOn() -> Bool {
        return on
    }
}
