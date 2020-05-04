//
//  Course.swift
//  Galf
//
//  Created by Davis Arthur on 5/2/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Course {
    
    let holes: [Hole]
    var par = 0
    
    init(holesIn: [Hole]) {
        holes = holesIn
        par = calculatePar()
    }
    
    func calculatePar() -> Int {
        var output = 0
        for hole in holes {
            output += hole.par
        }
        return output
    }
}
