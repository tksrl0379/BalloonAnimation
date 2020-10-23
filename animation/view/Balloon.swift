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
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView.removeFromSuperview()
    }
    
    private func addCurveTo(path: UIBezierPath, start: CGPoint, end: CGPoint, ratio: CurveTrajectoryRatio) {
        let dist = start.y - end.y
        let c1 = CGPoint(x: start.x + 30 * CGFloat(ratio.x) , y: end.y + dist)
        let c2 = CGPoint(x: start.x + 30 * CGFloat(ratio.x),   y: start.y - dist)
        path.addCurve(to: end, controlPoint1: c1, controlPoint2: c2)
    }

    private func addCurvesTo(path: UIBezierPath, start: CGPoint, end: CGPoint, counts: Int, ratios: [CurveTrajectoryRatio]) {
        var _start = start, _end = end
        let distance = start.y - end.y
        zip((1...counts), ratios).forEach { index, ratio in
            _end.y = start.y - distance * CGFloat(index)/CGFloat(counts)
            addCurveTo(path: path, start: _start, end: _end, ratio: ratio)
            _start = _end
        }
    }
    
    func animate(fromPoint start : CGPoint) {

        let randomX = CGFloat.random(in: -30...30)
        let randomY = CGFloat.random(in: 250...350)
        let end = CGPoint(x: start.x + randomX, y: start.y - randomY)
        
        let path = UIBezierPath()
        path.move(to: start)

        let counts = Int.random(in: 2...4) // 곡선 개수 설정
        let ratios = CurveTrajectoryFactory().randomStart(counts: counts)
        addCurvesTo(path: path, start: start, end: end, counts: counts, ratios: ratios)

        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        let duration = Int.random(in: 3...5) // 기간 설정
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
        bothAnimation.duration = CFTimeInterval(duration) // group 의 duration 과 path 를 그리는 duration 이 같아야 path 애니메이션이 중간에 안끊김
        bothAnimation.delegate = self // CAAnimationDelegate 받으려면 설정해줘야 함
        
        // 도착한 크기/위치로 남기려면 delegate 주석 및 아래 두 줄 주석해제 (실제 위치/크기가 변경되는건 아님)
//        bothAnimation.isRemovedOnCompletion = false
//        bothAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        imageView.layer.add(bothAnimation, forKey:"ballonAnimation")
    }

}


