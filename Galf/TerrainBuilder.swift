//
//  TerrainBuilder.swift
//  Galf
//
//  Created by Davis Arthur on 1/5/20.
//  Copyright © 2020 Davis Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

// Above are necessary extensions to the String class to ease code reading
struct TerrainBuilder {
    
    var map: SKTileMapNode
    var pin: SKSpriteNode
    var visited = [[Bool]]()
    var scene: GameScene
    
    init(mapIn: SKTileMapNode, pinIn: SKSpriteNode, sceneIn: GameScene) {
        map = mapIn
        pin = pinIn
        scene = sceneIn
        visited = [[Bool]](repeating: [Bool](repeating: false, count: map.numberOfColumns), count: map.numberOfRows)
    }
    
    mutating func build() {
        var terrainPoints = [CGPoint]()
        var islands = [SKShapeNode]()
        for col in 0...map.numberOfRows - 1 {
            for row in 0...map.numberOfRows - 1 {
                let def = map.tileDefinition(atColumn: col, row: row)
                if def != nil && visited[row][col] == false {
                    dfs(start: Tile(xIn: col, yIn: row, mapIn: map, code: (def?.name!)!), points: &terrainPoints)
                    print("Terrain Points: ")
                    print(terrainPoints)
                    islands.append(SKShapeNode(points: &terrainPoints, count: terrainPoints.count))
                    islands.last!.lineWidth = 2.0
                    islands.last!.strokeColor = SKColor.white
                    islands.last!.physicsBody = SKPhysicsBody(edgeChainFrom: islands.last!.path!)
                    islands.last!.physicsBody?.isDynamic = false
                }
            }
        }
        for island in islands {
            scene.addChild(island)
        }
    }
    
    // Depth first search used to generate terrain
    private mutating func dfs(start: Tile, points: inout [CGPoint]) {
        if (isVisited(tileIn: start)) {
            return
        }
        visit(tileIn: start)
        process(newTile: start, points: &points)
        
        for neighbor in start.getNeighbors() {
            dfs(start: neighbor, points: &points)
        }
        
    }
    
    // Has a tile bean visited?
    private func isVisited(tileIn: Tile) -> Bool {
        return visited[tileIn.y][tileIn.x]
    }
    
    // Visit a tile
    private mutating func visit(tileIn: Tile) {
        visited[tileIn.y][tileIn.x] = true
    }
    
    // Process a new tile
    private func process(newTile: Tile, points: inout [CGPoint]) {
        if (newTile.shapePoints == nil) {
            return
        }
        if (containsPin(tileIn: newTile)) {
            let cupPoints = createCup(center: map.centerOfTile(atColumn: newTile.x, row: newTile.y))
            if (points.isEmpty) {
                points += cupPoints
            }
            else if (points.last!.equalTo(cupPoints.first!)) {
                points += cupPoints
            }
            else if (points.last!.equalTo(cupPoints.last!)) {
                points += reverse(pointsIn: cupPoints)
            }
            else if (points.first!.equalTo(cupPoints.first!)) {
                points = reverse(pointsIn: cupPoints) + points
            }
            else if (points.first!.equalTo(cupPoints.last!)) {
                points = cupPoints + points
            }
        }
        else if (points.isEmpty) {
            points += newTile.shapePoints!
        }
        else if (points.last!.equalTo(newTile.shapePoints!.first!)) {
            points += newTile.shapePoints!
        }
        else if (points.last!.equalTo(newTile.shapePoints!.last!)) {
            points += reverse(pointsIn: newTile.shapePoints!)
        }
        else if (points.first!.equalTo(newTile.shapePoints!.first!)) {
            points = reverse(pointsIn: newTile.shapePoints!) + points
        }
        else if (points.first!.equalTo(newTile.shapePoints!.last!)) {
            points = newTile.shapePoints! + points
        }
    }
    
    // Create the points for the cup
    private func createCup(center: CGPoint) -> [CGPoint] {
        pin.position.y = center.y + pin.size.height / 2.3
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let leftCup = CGPoint(x: pin.position.x - 7.0, y: center.y)
        let leftCupBot = CGPoint(x: pin.position.x - 7.0, y: center.y - 12.0)
        let rightCupBot = CGPoint(x: pin.position.x + 7.0, y: center.y - 12.0)
        let rightCup = CGPoint(x: pin.position.x + 7.0, y: center.y)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        return [left, leftCup, leftCupBot, rightCupBot, rightCup, right]
    }
    
    // Does a given tile contain the pin?
    private func containsPin(tileIn: Tile) -> Bool {
        let pinPos = CGPoint(x: pin.position.x, y: pin.position.y - 30.0)
        let pinRow = map.tileRowIndex(fromPosition: pinPos)
        let pinCol = map.tileColumnIndex(fromPosition: pinPos)
        return tileIn.x == pinCol && tileIn.y == pinRow
    }
    
    
    // Reverse the order of an array of CGPoints
    private func reverse(pointsIn: [CGPoint]) -> [CGPoint] {
        var output = [CGPoint]()
        for point in pointsIn {
            output.insert(point, at: 0)
        }
        return output
    }
    
    // Are all of the tile points within the gamePoints already
    private func within(tilePoints: [CGPoint], gamePoints: [CGPoint]) -> Bool {
        for point in tilePoints {
            if (!gamePoints.contains(point)) {
                return false
            }
        }
        return true
    }
    
}
