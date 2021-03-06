//
//  TrendlineGenerator.swift
//  Examples
//
//  Created by ischuetz on 03/08/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public struct TrendlineGenerator {
    
    public static func trendline(chartPoints: [ChartPoint]) -> [ChartPoint] {
        
        if chartPoints.count < 2 {
            return []
        }
        
        let (sumX: Double, sumY: Double, sumXY: Double, sumXX: Double) = chartPoints.reduce((sumX: 0, sumY: 0, sumXY: 0, sumXX: 0)) {(tuple, chartPoint) in
            
            let x: Double = chartPoint.x.scalar
            let y: Double = chartPoint.y.scalar
            
            return (
                tuple.sumX + x,
                tuple.sumY + y,
                tuple.sumXY + x * y,
                tuple.sumXX + x * x
            )
        }
        
        let count: Double = Double(chartPoints.count)
        
        let b = (count * sumXY - sumX * sumY) / (count * sumXX - sumX * sumX)
        let a = (sumY - b * sumX) / count
        
        // equation of line: y = a + bx
        func y(x: Double) -> Double {
            return a + b * x
        }
        
        let first = chartPoints.first!
        let last = chartPoints.last!
        
        return [
            ChartPoint(x: ChartAxisValue(scalar: first.x.scalar), y: ChartAxisValue(scalar: y(first.x.scalar))),
            ChartPoint(x: ChartAxisValue(scalar: last.x.scalar), y: ChartAxisValue(scalar: y(last.x.scalar)))
        ]
    }
}