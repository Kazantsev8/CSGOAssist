//
//  RectangleLayer.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 05.07.2021.
//

import UIKit

//MARK: - Animation Layer
final class AnimationLayer: CAShapeLayer {
    
    //MARK: - Initialization
    override init() {
        super.init()
        fillColor = UIColor.clear.cgColor
        lineWidth = 5.0
        path = pathFull.cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) hsa not been implemented")
    }
    
    //MARK: - Private properties
    private let animationDuration: CFTimeInterval = 0.18
    
    private var pathFull: UIBezierPath {
        let path = UIBezierPath()
        //LETTER C
        path.move(to: CGPoint(x: 50.0, y: 0.0))
        path.addLine(to: CGPoint(x: 20.0, y: 0.0))
        path.addArc(withCenter: CGPoint(x: 20.0, y: 20.0),
                      radius: 20,
                      startAngle: CGFloat(3*Double.pi/2),
                      endAngle: CGFloat(Double.pi),
                      clockwise: false)
        path.addLine(to: CGPoint(x: 0.0, y: 80.0))
        path.addArc(withCenter: CGPoint(x: 20.0, y: 80.0),
                      radius: 20,
                      startAngle: CGFloat(Double.pi),
                      endAngle: CGFloat(Double.pi/2),
                      clockwise: false)
        path.addLine(to: CGPoint(x: 50.0, y: 100.0))
        //LETTER S
        path.addLine(to: CGPoint(x: 80.0, y: 100.0))
        path.addArc(withCenter: CGPoint(x: 80.0, y: 80.0),
                      radius: 20,
                      startAngle: CGFloat(Double.pi/2),
                      endAngle: 0,
                      clockwise: false)
        path.addLine(to: CGPoint(x: 100.0, y: 70.0))
        path.addArc(withCenter: CGPoint(x: 80.0, y: 70.0),
                      radius: 20,
                      startAngle: 0,
                      endAngle: CGFloat(3*Double.pi/2),
                      clockwise: false)
        path.addLine(to: CGPoint(x: 70.0, y: 50.0))
        path.addArc(withCenter: CGPoint(x: 70.0, y: 30.0),
                      radius: 20,
                      startAngle: CGFloat(Double.pi/2),
                      endAngle: CGFloat(Double.pi),
                      clockwise: true)
        path.addLine(to: CGPoint(x: 50.0, y: 20.0))
        path.addArc(withCenter: CGPoint(x: 70.0, y: 20.0),
                      radius: 20,
                      startAngle: CGFloat(Double.pi),
                      endAngle: CGFloat(3*Double.pi/2),
                      clockwise: true)
        path.addLine(to: CGPoint(x: 100.0, y: 0.0))
        //RECTANGLE
        path.move(to: CGPoint(x: 100.0, y: 0.0))
        path.addLine(to: CGPoint(x: 100.0, y: 80.0))
        path.addArc(withCenter: CGPoint(x: 80.0, y: 80.0),
                    radius: 20,
                    startAngle: 0.0,
                    endAngle: CGFloat(Double.pi/2),
                    clockwise: true)
        path.addLine(to: CGPoint(x: 20.0, y: 100.0))
        path.addArc(withCenter: CGPoint(x: 20.0, y: 80.0),
                    radius: 20,
                    startAngle: CGFloat(Double.pi/2),
                    endAngle: CGFloat(Double.pi),
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0.0, y: 20.0))
        path.addArc(withCenter: CGPoint(x: 20.0, y: 20.0),
                    radius: 20,
                    startAngle: CGFloat(Double.pi),
                    endAngle: CGFloat(3*Double.pi/2),
                    clockwise: true)
        path.addLine(to: CGPoint(x: 100.0, y: 0.0))
        path.close()
        return path
    }
    
    private var arcPathPre: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 99.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 99.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }

    private var arcPathStarting: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 80.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 80.0), controlPoint1: CGPoint(x: 30.0, y: 70.0), controlPoint2: CGPoint(x: 40.0, y: 90.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }

    private var arcPathLow: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 60.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 60.0), controlPoint1: CGPoint(x: 30.0, y: 65.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }

    private var arcPathMid: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 40.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 40.0), controlPoint1: CGPoint(x: 30.0, y: 30.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }

    private var arcPathHigh: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 20.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 20.0), controlPoint1: CGPoint(x: 30.0, y: 25.0), controlPoint2: CGPoint(x: 40.0, y: 10.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }

    private var arcPathComplete: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: -5.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: -5.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    //MARK: - Inteface function
    func animate(with color: UIColor) {
        strokeColor = color.cgColor
        
        let strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = 3
        
        let arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationPre.fromValue = arcPathPre.cgPath
        arcAnimationPre.toValue = arcPathStarting.cgPath
        arcAnimationPre.beginTime = strokeAnimation.beginTime + strokeAnimation.duration
        arcAnimationPre.duration = animationDuration

        let arcAnimationLow: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationLow.fromValue = arcPathStarting.cgPath
        arcAnimationLow.toValue = arcPathLow.cgPath
        arcAnimationLow.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
        arcAnimationLow.duration = animationDuration

        let arcAnimationMid: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationMid.fromValue = arcPathLow.cgPath
        arcAnimationMid.toValue = arcPathMid.cgPath
        arcAnimationMid.beginTime = arcAnimationLow.beginTime + arcAnimationLow.duration
        arcAnimationMid.duration = animationDuration

        let arcAnimationHigh: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationHigh.fromValue = arcPathMid.cgPath
        arcAnimationHigh.toValue = arcPathHigh.cgPath
        arcAnimationHigh.beginTime = arcAnimationMid.beginTime + arcAnimationMid.duration
        arcAnimationHigh.duration = animationDuration

        let arcAnimationComplete: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationComplete.fromValue = arcPathHigh.cgPath
        arcAnimationComplete.toValue = arcPathComplete.cgPath
        arcAnimationComplete.beginTime = arcAnimationHigh.beginTime + arcAnimationHigh.duration
        arcAnimationComplete.duration = animationDuration
        
        let group = CAAnimationGroup()
        group.animations = [strokeAnimation, arcAnimationPre, arcAnimationLow, arcAnimationMid, arcAnimationHigh, arcAnimationComplete]
        group.repeatCount = .infinity
        group.beginTime = 0.0
        group.duration = arcAnimationComplete.beginTime + arcAnimationComplete.duration
        group.fillMode = CAMediaTimingFillMode.forwards
        add(group, forKey: nil)
    }

}
