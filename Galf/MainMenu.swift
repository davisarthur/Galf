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
    private var cloudCount = 2
    private var cloudSpeed = CGFloat(1.0)
    private var clouds: [SKSpriteNode]!
    private var screenRect: CGRect!
    
    override func didMove(to view: SKView) {
        self.start = self.childNode(withName: "Start") as! SKLabelNode?
        self.screenRect = UIScreen.main.bounds
        self.clouds = [SKSpriteNode]()
        for i in 0...cloudCount - 1 {
            clouds.append(genCloud(index: i))
        }
        for cloud in clouds {
            addChild(cloud)
            print("Cloud Position: \(cloud.position)")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for i in 0...clouds.count - 1 {
            clouds[i].position.x += cloudSpeed
            if clouds[i].position.x - clouds[i].size.width / 2.0 > screenRect.width / 2.0 {
                clouds[i].position.x = -screenRect.width / 2.0 - clouds[i].size.width / 2.0
            }
        }
    }
    
    private func genCloud(index: Int) -> SKSpriteNode {
        let cloud = SKSpriteNode(imageNamed: "cloud\(Int.random(in: 0...1))")
        cloud.scale(to: CGSize(width: cloud.size.width / 5.0, height: cloud.size.height / 5.0))
        let xpos = CGFloat.random(in: -screenRect.width / 2.0...screenRect.width / 2.0)
        let lowerY = -screenRect.height / 2.0 + cloud.size.height / 2.0
        let upperY = screenRect.height / 2.0 - cloud.size.height / 2.0
        let ypos = CGFloat.random(in: lowerY + (upperY - lowerY) / CGFloat(cloudCount) * CGFloat(index)...lowerY + (upperY - lowerY) / CGFloat(cloudCount) * CGFloat(index + 1))
        cloud.position = CGPoint(x: xpos, y: ypos)
        cloud.zPosition = -50.0
        return cloud
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
