//
//  balloon.swift
//  animation
//
//  Created by a1111 on 2020/10/22.
//

import UIKit

struct Balloon {
    
    private let imageView: UIImageView
    
    init(imageView: UIImageView) {
        self.imageView = imageView
    }
    
    private func addCurveToPath(path: UIBezierPath, start: CGPoint, end: CGPoint, ratio: CurveTrajectoryRatio) {
        let dist = start.y - end.y
        let c1 = CGPoint(x: start.x + 100 * CGFloat(ratio.x) , y: end.y + dist * CGFloat(ratio.y))
        let c2 = CGPoint(x: start.x + 100 * CGFloat(ratio.x),   y: start.y + dist * CGFloat(-ratio.y))
        path.addCurve(to: end, controlPoint1: c1, controlPoint2: c2)
    }

    private func curves(path: UIBezierPath, start: CGPoint, end: CGPoint, counts: Int, ratios: [CurveTrajectoryRatio]) {
        var _start = start, _end = end
        let dist = start.y - end.y
        zip((1...counts), ratios).forEach { index, ratio in
            _end.y = start.y - dist * CGFloat(index)/CGFloat(counts)
            addCurveToPath(path: path, start: _start, end: _end, ratio: ratio)
            _start = _end
        }
    }
    
    func animate(fromPoint start : CGPoint, toPoint end: CGPoint) {
        let animation = CAKeyframeAnimation(keyPath: "position")

        let path = UIBezierPath()
        path.move(to: start)

        let counts = Int.random(in: 2...4)
        let ratios = CurveTrajectoryFactory().randomStart(counts: counts)
        curves(path: path, start: start, end: end, counts: counts, ratios: ratios)
        animation.path = path.cgPath

        animation.fillMode               = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.duration               = CFTimeInterval(Int.random(in: 3...5))
        animation.timingFunction        = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)

        imageView.layer.add(animation, forKey:"ballonAnimation")
    }

}


