//
//  GameHandler.swift
//  Galf
//
//  Created by Davis Arthur on 5/14/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameHandler {
    
    let players: [Player]
    let course: Course
    var currentHole = 0
    
    init(playersIn: [Player], courseIn: Course) {
        players = playersIn
        course = courseIn
    }
    
    // Returns the next hole on the course. If there is no next hole, returns nil
    func getNextHole() -> Hole? {
        self.currentHole += 1
        if (!course.hasHole(holeIn: currentHole)) {
            return nil
        }
        return course.getHole(holeNum: currentHole)!
    }
    
    func updateTotalScore() {
        let scores = players[0].scores
        var pars = [Int]()
        for hole in self.course.holes {
            pars.append(hole.getPar())
        }
        var netScore = 0
        for i in 0...scores.count - 1 {
            netScore += scores[i] - pars[i]
        }
        players[0].totalScore = netScore
    }
}
