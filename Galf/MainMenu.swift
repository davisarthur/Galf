//
//  MainMenu.swift
//  Galf
//
//  Created by Davis Arthur on 5/2/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MainMenu: SKScene {
    
    private var start : SKLabelNode!
    private var cloudCount = 3
    private var cloudSpeed = CGFloat(0.7)
    private var clouds: [Cloud]!
    private var tileMap: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        self.start = self.childNode(withName: "Start") as! SKLabelNode?
        self.tileMap = self.childNode(withName: "tileMap") as! SKTileMapNode?
        self.clouds = [Cloud]()
        while clouds.count < cloudCount {
            genCloud()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for i in 0...clouds.count - 1 {
            clouds[i].move()
        }
    }
    
    private func genCloud() {
        clouds.append(Cloud(velocityIn: cloudSpeed, cloudsIn: clouds, tileMapIn: tileMap))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if (start.contains(pos)) {
            loadSelectScreen()
        }
    }
    
    func loadSelectScreen() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = SelectScreen(fileNamed:"SelectScreen") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }
}
