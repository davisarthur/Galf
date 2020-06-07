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
    private var start: SKLabelNode!
    private var quit: SKLabelNode!
    private var characterLabel: SKLabelNode!
    private var courseLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.courses = self.childNode(withName: "courses")
        self.characters = self.childNode(withName: "characters")
        self.courseImages = courses.childNode(withName: "courseImages")
        self.characterLabel = characters.childNode(withName: "playerLabel") as? SKLabelNode
        self.courseLabel = courses.childNode(withName: "courseLabel") as? SKLabelNode
        
        // Hide all courses besides first
        var first = true
        for child in courseImages!.children {
            if (!first) {
                child.isHidden = true
                continue
            }
            first = false
            courseLabeler(nameIn: child.name!)
        }
        self.characterImages = characters.childNode(withName: "characterImages")
        
        // Hide all characters besides first
        first = true
        for child in characterImages.children {
            if (!first) {
                child.isHidden = true
                continue
            }
            first = false
            characterLabeler(nameIn: child.name!)
        }
        
        self.start = self.childNode(withName: "start") as! SKLabelNode?
        self.quit = self.childNode(withName: "exit") as! SKLabelNode?
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
                characterLabeler(nameIn: child.name!)
                return
            }
        }
        characterImages.children.first?.isHidden = false
        characterLabeler(nameIn: (characterImages.children.first?.name)!)
    }

    private func characterLabeler(nameIn: String) {
        if nameIn == "DAV" {
            characterLabel.text = "Dav"
            return
        }
        if nameIn == "HOG" {
            characterLabel.text = "Hog"
            return
        }
        
    }
    
    private func courseLabeler(nameIn: String) {
        if nameIn == "bigbee" {
            courseLabel.text = "Big-Bee"
            return
        }
        if nameIn == "ballard" {
            courseLabel.text = "Ballard"
            return
        }
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
                courseLabeler(nameIn: child.name!)
                return
            }
        }
        courseImages.children.first?.isHidden = false
        courseLabeler(nameIn: (courseImages.children.first?.name)!)
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
