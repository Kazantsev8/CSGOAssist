//
//  LoadingAnimationView.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 05.07.2021.
//

import UIKit

//MARK: - Loading Animation View
final class LoadingAnimationView: UIView {
    
    private let animationLayer = AnimationLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        layer.addSublayer(animationLayer)
        animationLayer.animate(with: .white)
    }
    
    func stopAnimate() {
        layer.removeAllAnimations()
        animationLayer.removeAllAnimations()
        animationLayer.removeFromSuperlayer()
    }
    
}
