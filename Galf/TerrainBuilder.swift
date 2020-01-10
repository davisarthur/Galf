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

struct TerrainBuilder {
    
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
