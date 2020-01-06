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
    
//    static func createTop(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x - 16.0, y: center.y)
//        let right = CGPoint(x: center.x + 16.0, y: center.y)
//        output.append(left)
//        output.append(right)
//        return output
//    }
//
//    static func createTopRight(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x - 16.0, y: center.y)
//        let middle = CGPoint(x: center.x - 8.0, y: center.y - 4.0)
//        let right = CGPoint(x: center.x, y: center.y - 16.0)
//        output.append(left)
//        output.append(middle)
//        output.append(right)
//        return output
//    }
//
//    static func createTopLeftSlant(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x, y: center.y + 16.0)
//        let right = CGPoint(x: center.x + 16.0, y: center.y - 16.0)
//        output.append(left)
//        output.append(right)
//        return output
//    }
//
//    static func createLeftCurved(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x, y: center.y + 16.0)
//        let middle = CGPoint(x: center.x + 8.0, y: center.y + 4.0)
//        let right = CGPoint(x: center.x + 16.0, y: center.y)
//        output.append(left)
//        output.append(middle)
//        output.append(right)
//        return output
//    }
//
//    static func createBotLeftSlant(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x - 16.0, y: center.y + 16.0)
//        let right = CGPoint(x: center.x, y: center.y - 16.0)
//        output.append(left)
//        output.append(right)
//        return output
//    }
//
//    static func createTopLeft(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x, y: center.y - 16.0)
//        let middle = CGPoint(x: center.x + 8.0, y: center.y - 4.0)
//        let right = CGPoint(x: center.x + 16.0, y: center.y)
//        output.append(left)
//        output.append(middle)
//        output.append(right)
//        return output
//    }
//
//    static func createRightCurved(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x - 16.0, y: center.y)
//        let middle = CGPoint(x: center.x - 8.0, y: center.y + 4.0)
//        let right = CGPoint(x: center.x, y: center.y + 16.0)
//        output.append(left)
//        output.append(middle)
//        output.append(right)
//        return output
//    }
//
//    static func createTopRightSlant(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x - 16.0, y: center.y - 16.0)
//        let right = CGPoint(x: center.x, y: center.y + 16.0)
//        output.append(left)
//        output.append(right)
//        return output
//    }
//
//    static func createBotRightSlant(center: CGPoint) -> [CGPoint] {
//        var output : [CGPoint] = []
//        let left = CGPoint(x: center.x, y: center.y - 16.0)
//        let right = CGPoint(x: center.x + 16.0, y: center.y + 16.0)
//        output.append(left)
//        output.append(right)
//        return output
//    }
    
    static func createTop(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func createTopRight(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func createTopLeftSlant(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func createLeftCurved(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y + 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func createBotLeftSlant(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y + 16.0)
        let right = CGPoint(x: center.x, y: center.y - 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func createTopLeft(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let middle = CGPoint(x: center.x + 8.0, y: center.y - 4.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func createRightCurved(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y)
        let middle = CGPoint(x: center.x - 8.0, y: center.y + 4.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(middle)
        output.append(right)
        return output
    }
    
    static func createTopRightSlant(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x - 16.0, y: center.y - 16.0)
        let right = CGPoint(x: center.x, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
    static func createBotRightSlant(center: CGPoint) -> [CGPoint] {
        var output : [CGPoint] = []
        let left = CGPoint(x: center.x, y: center.y - 16.0)
        let right = CGPoint(x: center.x + 16.0, y: center.y + 16.0)
        output.append(left)
        output.append(right)
        return output
    }
    
}
