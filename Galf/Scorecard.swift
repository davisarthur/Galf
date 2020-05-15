//
//  Scorecard.swift
//  Galf
//
//  Created by Davis Arthur on 5/13/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Scorecard: SKScene {
    
    private var nextHole: SKLabelNode!
    private var quit: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.nextHole = self.childNode(withName: "nextHole") as! SKLabelNode?
        self.quit = self.childNode(withName: "quit") as! SKLabelNode?
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if (nextHole.contains(pos)) {
            loadNextHole()
        }
        if (quit.contains(pos)) {
            loadMainMenu()
        }
        
    }
    
    func loadNextHole() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = GameScene(fileNamed:"GameScene") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }
        
        scene.loadHole(gameHandler: GameHandler(playersIn: [Player(nameIn: "HOG")], courseIn: BallardLinks().course))
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    func loadMainMenu() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = MainMenu(fileNamed: "MainMenu") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }
    
}
