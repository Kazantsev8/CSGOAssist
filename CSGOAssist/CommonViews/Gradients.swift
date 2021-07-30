//
//  CommonView.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 24.07.2021.
//

import UIKit

//MARK: - Gradients for using in application
enum Gradient: Int, CaseIterable {
    
    case horizon = 0
    
    var colors: [CGColor] {
        switch self {
        case .horizon:
            return [UIColor(red: 0.00, green: 0.22, blue: 0.45, alpha: 1.00).cgColor,
                    UIColor(red: 1.00, green: 0.74, blue: 0.35, alpha: 1.00).cgColor]
        }
    }
    
    var colorsUI: [UIColor] {
        switch self {
        case .horizon:
            return [UIColor(red: 0.00, green: 0.22, blue: 0.45, alpha: 1.00),
                    UIColor(red: 1.00, green: 0.74, blue: 0.35, alpha: 1.00)]
        }
    }
    
}
