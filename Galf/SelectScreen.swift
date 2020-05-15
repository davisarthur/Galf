//
//  SelectScreen.swift
//  Galf
//
//  Created by Davis Arthur on 5/14/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class SelectScreen: SKScene {
    
    private var courses: SKNode!
    private var characters: SKNode!
    private var start: SKLabelNode!
    private var quit: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.courses = self.childNode(withName: "courses")
        self.characters = self.childNode(withName: "characters")
        self.start = self.childNode(withName: "start") as! SKLabelNode?
        self.quit = self.childNode(withName: "quit") as! SKLabelNode?
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if (start.contains(pos)) {
            loadGame()
        }
        if (quit.contains(pos)) {
            loadMainMenu()
        }
    }
    
    func loadMainMenu() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = MainMenu(fileNamed:"MainMenu") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }
    
    func loadGame() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = Scorecard(fileNamed:"Scorecard") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }
}
