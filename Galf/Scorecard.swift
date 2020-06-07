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
    private var score = SKNode()
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
        let parLabels = holesToLabels(scoresIn: pars, leftX: -240.0, middleY: 10.0)
        for label in parLabels {
            par.addChild(label)
        }
        
        addChild(score)
        var scores = [Int]()
        for s in handler.players[0].scores {
            scores.append(s)
        }
        let scoreLabels = holesToLabels(scoresIn: scores, leftX: -240.0, middleY: -85.0)
        for label in scoreLabels {
            score.addChild(label)
        }
        
        
        addChild(player)
        player.text = handler.players[0].playerName
        player.fontName = "I pixel u"
        player.fontSize = CGFloat(64.0)
        player.fontColor = UIColor.black
        player.position = CGPoint(x: -size.width / 4.0 * 1.08, y: -size.height / 8.0 * 0.95)
        player.zPosition = CGFloat(15.0)
    }
    
    func holesToLabels(scoresIn: [Int], leftX: CGFloat, middleY: CGFloat) -> [SKLabelNode] {
        var output = [SKLabelNode]()
        let interval = 61.0
        if scoresIn.count == 0 {
            return [SKLabelNode()]
        }
        for i in 0...scoresIn.count - 1 {
            let newLabel = SKLabelNode()
            newLabel.text = String(scoresIn[i])
            newLabel.fontName = "I pixel u"
            newLabel.fontSize = CGFloat(55.0)
            newLabel.fontColor = UIColor.black
            newLabel.position = CGPoint(x: leftX + CGFloat(Double(i) * interval) , y: middleY)
            newLabel.zPosition = CGFloat(15.0)
            output.append(newLabel)
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
