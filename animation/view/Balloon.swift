//
//  balloon.swift
//  animation
//
//  Created by a1111 on 2020/10/22.
//

import UIKit

class Balloon: NSObject, CAAnimationDelegate {

    
    private let imageView: UIImageView
    
    init(imageView: UIImageView) {
        self.imageView = imageView
        print(imageView.frame)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView.removeFromSuperview()
    }
    
    private func addCurveToPath(path: UIBezierPath, start: CGPoint, end: CGPoint, ratio: CurveTrajectoryRatio) {
        let dist = start.y - end.y
        let c1 = CGPoint(x: start.x + 30 * CGFloat(ratio.x) , y: end.y + dist)
        let c2 = CGPoint(x: start.x + 30 * CGFloat(ratio.x),   y: start.y - dist)
        path.addCurve(to: end, controlPoint1: c1, controlPoint2: c2)
    }

    private func curves(path: UIBezierPath, start: CGPoint, end: CGPoint, counts: Int, ratios: [CurveTrajectoryRatio]) {
        var _start = start, _end = end
        let distance = start.y - end.y
        zip((1...counts), ratios).forEach { index, ratio in
            _end.y = start.y - distance * CGFloat(index)/CGFloat(counts)
            addCurveToPath(path: path, start: _start, end: _end, ratio: ratio)
            _start = _end
        }
    }
    
    func animate(fromPoint start : CGPoint, toPoint end: CGPoint) {

        let path = UIBezierPath()
        path.move(to: start)

        let counts = Int.random(in: 2...4)
        let ratios = CurveTrajectoryFactory().randomStart(counts: counts)
        curves(path: path, start: start, end: end, counts: counts, ratios: ratios)

        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        let duration = Int.random(in: 3...5)
        pathAnimation.duration = CFTimeInterval(duration)
        pathAnimation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        
        let sizeAnimation = CABasicAnimation(keyPath: "transform.scale")
        sizeAnimation.fromValue = 1
        sizeAnimation.toValue = 2
        sizeAnimation.duration = 1
        sizeAnimation.autoreverses = true
        sizeAnimation.repeatCount = .infinity

        let bothAnimation = CAAnimationGroup()
        bothAnimation.animations = [pathAnimation, sizeAnimation]
        bothAnimation.duration = CFTimeInterval(duration)
        bothAnimation.delegate = self // CAAnimationDelegate 받으려면 설정해줘야 함.
        
        // 도착한 자리에 남기려면 delegate 주석 및 아래 두 줄 주석해제
//        bothAnimation.isRemovedOnCompletion = false
//        bothAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        imageView.layer.add(bothAnimation, forKey:"ballonAnimation")
    }

}


