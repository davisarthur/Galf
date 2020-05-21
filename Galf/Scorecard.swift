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
    private var par = SKLabelNode()
    private var player = SKLabelNode()
    private var score = SKLabelNode()
    private var handler: GameHandler!
    
    override func didMove(to view: SKView) {
        self.nextHole = self.childNode(withName: "nextHole") as! SKLabelNode?
        self.quit = self.childNode(withName: "quit") as! SKLabelNode?
        writeToCard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print(pos)
        if (nextHole.contains(pos)) {
            loadNextHole()
        }
        if (quit.contains(pos)) {
            loadMainMenu()
        }
    }
    
    func writeToCard() {
        addChild(par)
        var pars = [Int]()
        for hole in handler.course.holes {
            pars.append(hole.getPar())
        }
        par.text = String(holesToString(scoresIn: pars))
        par.fontSize = CGFloat(64.0)
        par.fontColor = UIColor.black
        par.position = CGPoint(x: -size.width / 5.0 * 0.8, y: size.height / 40.0 * 0.55)
        par.zPosition = CGFloat(15.0)
        
        addChild(score)
        var scores = [Int]()
        for s in handler.players[0].scores {
            scores.append(s)
        }
        score.text = String(holesToString(scoresIn: scores))
        score.fontSize = CGFloat(64.0)
        score.fontColor = UIColor.black
        score.position = CGPoint(x: -size.width / 5.0 * 0.8, y: -size.height / 8.0 * 0.95)
        score.zPosition = CGFloat(15.0)
        
        addChild(player)
        player.text = handler.players[0].name
        player.fontSize = CGFloat(64.0)
        player.fontColor = UIColor.black
        player.position = CGPoint(x: -size.width / 4.0 * 1.1, y: -size.height / 8.0 * 0.95)
        player.zPosition = CGFloat(15.0)
    }
    
    func holesToString(scoresIn: [Int]) -> String {
        var output = ""
        for score in scoresIn {
            output.append(String(score) + "\t")
        }
        return output
    }

    func setHandler(handlerIn: GameHandler) {
        self.handler = handlerIn
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
        
        scene.loadHole(gameHandler: handler)
        
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
