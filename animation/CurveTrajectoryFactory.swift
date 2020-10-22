//
//  CurveTrajectoryFactory.swift
//  animation
//
//  Created by a1111 on 2020/10/22.
//

import Foundation

struct CurveTrajectoryRatio {
    let x: Float
    let y: Float
}

struct CurveTrajectoryFactory {
    
    private var rightCurve: [CurveTrajectoryRatio] = [
        CurveTrajectoryRatio(x: 1.03, y: 0.8), CurveTrajectoryRatio(x: 1.0, y: 0.9),
        CurveTrajectoryRatio(x: 1.05, y: 1.2), CurveTrajectoryRatio(x: 0.95, y: 0.7)
    ]
    private var leftCurve: [CurveTrajectoryRatio] = [
        CurveTrajectoryRatio(x: -1.03, y: 0.8), CurveTrajectoryRatio(x: -1.0, y: 0.9),
        CurveTrajectoryRatio(x: -1.05, y: 1.2), CurveTrajectoryRatio(x: -0.95, y: 0.7)
    ]
    
    private func randomLeftCurve() -> CurveTrajectoryRatio {
        leftCurve.randomElement() ?? CurveTrajectoryRatio(x: -1.0, y: 0.8)
    }
    
    private func randomRightCurve() -> CurveTrajectoryRatio {
        rightCurve.randomElement() ?? CurveTrajectoryRatio(x: 1.0, y: 0.8)
    }
    
    private func appending(counts: Int, random: Int) -> [CurveTrajectoryRatio] {
        var ratios = [CurveTrajectoryRatio]()
        (0..<counts).forEach {
            if $0 % 2 == random {
                ratios.append(randomLeftCurve())
            } else {
                ratios.append(randomRightCurve())
            }
        }
        
        return ratios
    }
    
    func randomStart(counts: Int) -> [CurveTrajectoryRatio] {
        let random = Int.random(in: 0...1)
        return appending(counts: counts, random: random)
    }
    
}
