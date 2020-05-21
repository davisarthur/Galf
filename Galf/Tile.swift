//
//  Tile.swift
//  Galf
//
//  Created by Davis Arthur on 5/8/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Tile {
    
    let x: Int
    let y: Int
    let map: SKTileMapNode
    var shapePoints: [CGPoint]? = []
    
    init(xIn: Int, yIn: Int, mapIn: SKTileMapNode, code: String) {
        x = xIn
        y = yIn
        map = mapIn
        shapePoints = getShapePoints(codeIn: code, tileCenter: map.centerOfTile(atColumn: xIn, row: yIn))
    }
    
    // Gets all the surrounding tiles that line up with this tile
    func getNeighbors() -> [Tile] {
        var neighbors = [Tile]()
        for i in -1...1 {
            for j in -1...1 {
                // Don't include self as neighbor
                if (i == 0 && j == 0) {
                    continue
                }
                let xPos = self.x + i
                let yPos = self.y + j
                // Make sure there is a tile at neighbor's location.
                if (!exists(xIn: xPos, yIn: yPos)) {
                    continue
                }
                let newTile = Tile(xIn: xPos, yIn: yPos, mapIn: self.map, code: (map.tileDefinition(atColumn: xPos, row: yPos)?.name!)!)
                
                if (self.touching(otherTile: newTile)) {
                    neighbors.append(newTile)
                }
            }
        }
        return neighbors
    }
    
    // Does this tile line up with another tile?
    private func touching(otherTile: Tile) -> Bool {
        if (self.shapePoints == nil || otherTile.shapePoints == nil) {
            return false
        }
        // Case 0
        if self.shapePoints!.last!.equalTo(otherTile.shapePoints![0]) {
            return true
        }
        // Case 1
        if self.shapePoints!.last!.equalTo(otherTile.shapePoints!.last!) {
            return true
        }
        // Case 2
        if self.shapePoints![0].equalTo(otherTile.shapePoints![0]) {
            return true
        }
        // Case 3
        if self.shapePoints![0].equalTo(otherTile.shapePoints!.last!) {
            return true
        }
        // not touching
        return false
    }
    
    func equal(tileIn: Tile) -> Bool {
        return self.x == tileIn.x && self.y == tileIn.y
    }
    
    // Is this coordinate in the tile's tile map?
    private func exists(xIn: Int, yIn: Int) -> Bool {
        if (xIn < 0 || xIn >= map.numberOfColumns || yIn < 0 || yIn >= map.numberOfRows) {
            return false
        }
        if (map.tileDefinition(atColumn: xIn, row: yIn) == nil) {
            return false
        }
        return true
    }
    
    // Reads in tile code
    private func read(code: String) -> [String] {
        let texture = String(code[0])
        let shape = String(code[1...])
        print("Texture: \(texture) , Shape: \(shape)")
        return [texture, shape]
    }
    
    // Get the shape of a given tile
    private func getShapePoints(codeIn: String, tileCenter: CGPoint) -> [CGPoint]? {
        let data = read(code: codeIn)
        let shape = data[1]
        
        // set shape
        if shape == "1" {
            return create1(center: tileCenter)
        }
        else if shape == "2" || shape == "8" {
            return create2or8(center: tileCenter)
        }
        else if shape == "3" {
            return create3(center: tileCenter)
        }
        else if shape == "4" || shape == "6" {
            return create4or6(center: tileCenter)
        }
        else if shape == "5" {
            print("Center tile, no points")
            return nil
        }
        else if shape == "7" {
            return create7(center: tileCenter)
        }
        else if shape == "9" {
            return create9(center: tileCenter)
        }
        else if shape == "10A" {
            return create10A(center: tileCenter)
        }
        else if shape == "10B" {
            return create10B(center: tileCenter)
        }
        else if shape == "10C" {
            return create10C(center: tileCenter)
        }
        else if shape == "11A" {
            return create11A(center: tileCenter)
        }
        else if shape == "11B" {
            return create11B(center: tileCenter)
        }
        else if shape == "11C" {
            return create11C(center: tileCenter)
        }
        else if shape == "12A" {
            return create12A(center: tileCenter)
        }
        else if shape == "12B" {
            return create12B(center: tileCenter)
        }
        else if shape == "12C" {
            return create12C(center: tileCenter)
        }
        else if shape == "13A" {
            return create13A(center: tileCenter)
        }
        else if shape == "13B" {
            return create13B(center: tileCenter)
        }
        else if shape == "13C" {
            return create13C(center: tileCenter)
        }
        else {
            print("Error: Invalid shape code")
            return nil
        }
    }
    
    private func create1(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    // Tiles with shape 2 or 8 have the same collider
    private func create2or8(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create3(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    // Tiles with shape 4 or 6 have the same collider
    private func create4or6(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let top = CGPoint(x: center.x, y: center.y + 16.0)
        let bottom = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(top)
        output.append(bottom)
        return output
    }
    
    // Tile 5 has no collider
    private func create7(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    private func create9(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    private func create10A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    private func create10B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y - 16.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create10C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create11A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    private func create11B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create11C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y + 16.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create12A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    private func create12B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y + 16.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create12C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create13A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    private func create13B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    private func create13C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y - 16.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
}
