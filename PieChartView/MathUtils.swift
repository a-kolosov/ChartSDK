//
//  MathUtils.swift
//  PieChart
//
//  Created by Anton Kolosov on 10/16/19.
//  Copyright © 2019 Anton Kolosov. All rights reserved.
//

import Foundation
import CoreGraphics

class MathUtils {
    
    enum Quarter {
        case first
        case second
        case third
        case forth
        case none
    }
    
    static func convertDegreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat.pi / 180.0
    }
    
    static func convertRadiansToDegrees(radians: CGFloat) -> CGFloat {
        return radians * 180.0 / CGFloat.pi
    }
    
    // angle in radians
    static func arcPoint(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x = center.x + radius * sin(CGFloat.pi / 2 - angle)
        let y = center.y + radius * cos(CGFloat.pi / 2 - angle)
        
        return CGPoint(x: x, y: y)
    }
    
    // calculate in what quarter point is displayed
    static func calculateQuarter(center: CGPoint, point: CGPoint) -> Quarter {
        let firstQuarterRect = CGRect(x: center.x, y: 0, width: center.x, height: center.y)
        let secondQuarterRect = CGRect(x: 0, y: 0, width: center.x, height: center.y)
        let thirdQuarterRect = CGRect(x: 0, y: center.y, width: center.x, height: center.y)
        let forthQuarterRect = CGRect(x: center.x, y: center.y, width: center.x, height: center.y)
        
        if firstQuarterRect.contains(point) {
            return .first
        } else if secondQuarterRect.contains(point) {
            return .second
        } else if thirdQuarterRect.contains(point) {
            return .third
        } else if forthQuarterRect.contains(point) {
            return .forth
        } else {
            return .none
        }
    }
}
