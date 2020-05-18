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
    private var courseImages: SKNode!
    private var characterImages: SKNode!
    private var start: SKSpriteNode!
    private var quit: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.courses = self.childNode(withName: "courses")
        self.characters = self.childNode(withName: "characters")
        
        self.courseImages = courses.childNode(withName: "courseImages")
        
        // Hide all courses besides first
        var first = true
        for child in courseImages!.children {
            if (!first) {
                child.isHidden = true
            }
            first = false
        }
        self.characterImages = characters.childNode(withName: "characterImages")
        
        // Hide all characters besides first
        first = true
        for child in characterImages.children {
            if (!first) {
                child.isHidden = true
            }
            first = false
        }
        
        self.start = self.childNode(withName: "start") as! SKSpriteNode?
        self.quit = self.childNode(withName: "exit") as! SKSpriteNode?
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
        if (courses.contains(pos)) {
            nextCourse()
        }
        if (characters.contains(pos)) {
            nextCharacter()
        }
    }
    
    func nextCharacter() {
        var trigger = false
        for child in characterImages.children {
            if (child.isHidden == false) {
                child.isHidden = true
                trigger = true
                continue
            }
            if (trigger) {
                child.isHidden = false
                return
            }
        }
        characterImages.children.first?.isHidden = false
    }

    // switch display to next course
    func nextCourse() {
        var trigger = false
        for child in courseImages.children {
            if (child.isHidden == false) {
                child.isHidden = true
                trigger = true
                continue
            }
            if (trigger) {
                child.isHidden = false
                return
            }
        }
        courseImages.children.first?.isHidden = false
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
    
    private func loadGame() {
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        guard let scene = Scorecard(fileNamed:"Scorecard") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        scene.setHandler(handlerIn: GameHandler(playersIn: [getCharacter()!], courseIn: getCourse()!))
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    private func getCharacter() -> Player? {
        for child in characterImages.children {
            if (child.isHidden == false) {
                return Player(nameIn: child.name!)
            }
        }
        return nil
    }
    
    private func getCourse() -> Course? {
        for child in courseImages.children {
            if (child.isHidden == false) {
                return courseReader(courseName: child.name)
            }
        }
        return nil
    }
    
    private func courseReader(courseName: String?) -> Course? {
        if (courseName == "ballard") {
            return BallardLinks().course
        }
        if (courseName == "bigbee") {
            print("Course in design.")
            return nil
        }
        return nil
    }
}
