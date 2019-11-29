//
//  PieChart.swift
//  PieChart
//
//  Created by Anton Kolosov on 10/15/19.
//  Copyright © 2019 Anton Kolosov. All rights reserved.
//

import UIKit

public class PieChart: UIView {
    public enum SectorSeparatorStyle {
        case line(width: CGFloat, color: UIColor)
        case none
    }
    
    public struct SectorData {
        let percentage: Float
        let color: UIColor
        let text: NSAttributedString
        
        public init(percentage: Float, color: UIColor, text: NSAttributedString) {
            self.percentage = percentage
            self.color = color
            self.text = text
        }
    }
    
    public var sectors = [SectorData]() {
        didSet {
            prepareSectorsData()
            setNeedsDisplay()
        }
    }
    public var sectorSeparatorStyle: SectorSeparatorStyle = .none
    // 0 < hugging < 1 inside sector
    // 1 < hugging < infinite outside sector
    public var sectorTextPositionHugging: CGFloat = 1
    public var radius: CGFloat = 0
    
    private var sectorPercentages = [CGFloat]()
    private var sectorColors = [UIColor]()
    private var sectorTexts = [NSAttributedString]()
    
    override public func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let sectors = createSectorsPath(center: center, radius: radius, percentages: sectorPercentages)
        for i in 0..<sectors.count {
            let color = sectorColors[i]
            color.setFill()
            let path = sectors[i]
            path.fill()
        }
        
        switch sectorSeparatorStyle {
        case .line(let width, let color):
            let separators = createSectorSeparatorPaths(center: center, radius: radius, width: width, percentages: sectorPercentages)
            color.setStroke()
            for s in separators {
                s.stroke()
            }
            
        case .none:
            break
        }
        
        let insideSectorCenters = createSectorCenters(center: center, radius: radius * sectorTextPositionHugging, percentages: sectorPercentages)
        for i in 0..<insideSectorCenters.count {
            let point = insideSectorCenters[i]
            let text = sectorTexts[i]
            var textRect = CGRect.zero
            if sectorTextPositionHugging >= 1 {
                textRect = calculateTextRect(startPoint: point, size: text.size(), center: center)
            } else if sectorTextPositionHugging < 1 {
                textRect = calculateIndideTextRect(startPoint: point, size: text.size(), center: center)
            }
            text.draw(in: textRect)
        }
    }
    
    private func prepareSectorsData() {
        sectorPercentages = sectors.map( {CGFloat($0.percentage)} )
        sectorColors = sectors.map( {$0.color} )
        sectorTexts = sectors.map( {$0.text} )
    }
    
    private func createSectorsPath(center: CGPoint, radius: CGFloat, percentages: [CGFloat]) -> [UIBezierPath] {
        var lastAngle: CGFloat = 0
        var sectors = [UIBezierPath]()
        for p: CGFloat in percentages {
            let angleLength = CGFloat.pi * 2 * p
            let arcStartPoint = MathUtils.arcPoint(center: center, radius: radius, angle: lastAngle)
            let sectorPath = UIBezierPath()
            sectorPath.move(to: center)
            sectorPath.addLine(to: arcStartPoint)
            sectorPath.addArc(withCenter: center, radius: radius, startAngle: lastAngle, endAngle: lastAngle + angleLength, clockwise: true)
            sectorPath.addLine(to: center)
            
            sectors.append(sectorPath)
            lastAngle += angleLength
        }
        
        return sectors
    }
    
    private func createSectorSeparatorPaths(center: CGPoint, radius: CGFloat, width: CGFloat, percentages: [CGFloat]) -> [UIBezierPath] {
        var lastAngle: CGFloat = 0
        var separators = [UIBezierPath]()
        for p: CGFloat in percentages {
            let angleLength = CGFloat.pi * 2 * p
            let arcStartPoint = MathUtils.arcPoint(center: center, radius: radius, angle: lastAngle)
            let separatorPath = UIBezierPath()
            separatorPath.lineWidth = width
            separatorPath.move(to: center)
            separatorPath.addLine(to: arcStartPoint)
            separators.append(separatorPath)
            
            lastAngle += angleLength
        }
        
        return separators
    }
    
    private func createSectorCenters(center: CGPoint, radius: CGFloat, percentages: [CGFloat]) -> [CGPoint] {
        var lastAngle: CGFloat = 0
        var sectorCenters = [CGPoint]()
        for p: CGFloat in percentages {
            let angleLength = CGFloat.pi * 2 * p
            let arcCenterPoint = MathUtils.arcPoint(center: center, radius: radius, angle: (lastAngle + angleLength / 2))
            sectorCenters.append(arcCenterPoint)
            
            lastAngle += angleLength
        }
        
        return sectorCenters
    }
    
    // rect is outside of sector
    private func calculateTextRect(startPoint: CGPoint, size: CGSize, center: CGPoint) -> CGRect {
        let quarter = MathUtils.calculateQuarter(center: center, point: startPoint)
        let initialRect = CGRect(x: startPoint.x, y: startPoint.y, width: size.width, height: size.height)
        switch quarter {
        case .first:
            return initialRect.applying(CGAffineTransform(translationX: 0, y: -size.height))
        case .second:
            return initialRect.applying(CGAffineTransform(translationX: -size.width, y: -size.height))
        case .third:
            return initialRect.applying(CGAffineTransform(translationX: -size.width, y: 0))
        case .forth:
            return initialRect.applying(CGAffineTransform(translationX: 0, y: 0))
        default:
            return initialRect
        }
    }
    
    private func calculateIndideTextRect(startPoint: CGPoint, size: CGSize, center: CGPoint) -> CGRect {
        let x = startPoint.x - size.width / 2
        let y = startPoint.y - size.height / 2
        let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
        
        return rect
    }
}
