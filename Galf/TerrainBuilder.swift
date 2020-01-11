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
    
    static func buildTile(tileCode: String, tileCenter: CGPoint) {
        var tile: SKShapeNode
        let data = read(code: tileCode)
        let texture = data[0]
        let shape = data[1]
        var points: [CGPoint]
        
        // set shape
        if shape == "1" {
            points = create1(center: tileCenter)
        }
        else if shape == "2" || shape == "8" {
            points = create2or8(center: tileCenter)
        }
        else if shape == "3" {
            points = create3(center: tileCenter)
        }
        else if shape == "4" || shape == "6" {
            points = create4or6(center: tileCenter)
        }
        else if shape == "5" {
            print("Center tile, no points")
        }
        else if shape == "7" {
            points = create7(center: tileCenter)
        }
        else if shape == "9" {
            points = create9(center: tileCenter)
        }
        else if shape == "10A" {
            points = create10A(center: tileCenter)
        }
        else if shape == "10B" {
            points = create10B(center: tileCenter)
        }
        else if shape == "10C" {
            points = create10C(center: tileCenter)
        }
        else if shape == "11A" {
            points = create11A(center: tileCenter)
        }
        else if shape == "11B" {
            points = create11B(center: tileCenter)
        }
        else if shape == "11C" {
            points = create11C(center: tileCenter)
        }
        else if shape == "12A" {
            points = create12A(center: tileCenter)
        }
        else if shape == "12B" {
            points = create12B(center: tileCenter)
        }
        else if shape == "12C" {
            points = create12C(center: tileCenter)
        }
        else if shape == "13A" {
            points = create13A(center: tileCenter)
        }
        else if shape == "13B" {
            points = create13B(center: tileCenter)
        }
        else if shape == "13C" {
            points = create13C(center: tileCenter)
        }
        else {
            print("Error: Invalid shape code")
        }
        
        // set ground type
        if texture == "R" {
        }
    }
    
    static func read(code: String) -> [String] {
        let texture = String(code[0])
        let shape = String(code[1...])
        print("Texture: \(texture) , Shape: \(shape)")
        return [texture, shape]
    }
    
    static func create1(center: CGPoint) -> [CGPoint] {
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
    static func create2or8(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create3(center: CGPoint) -> [CGPoint] {
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
    static func create4or6(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let top = CGPoint(x: center.x, y: center.y + 16.0)
        let bottom = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(top)
        output.append(bottom)
        return output
    }
    
    // Tile 5 has no collider
    static func create7(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func create9(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func create10A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func create10B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y - 16.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create10C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create11A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func create11B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create11C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y + 16.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create12A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func create12B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y + 16.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create12C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create13A(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func create13B(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func create13C(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y - 16.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
}
