//
//  Extensions.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

//MARK: - Added add() function to UIViewController
extension UIViewController {
    
    func add(in parent: UIViewController) {
        parent.addChild(self)
        parent.view.addSubview(self.view)
        self.didMove(toParent: parent)
    }
    
}
