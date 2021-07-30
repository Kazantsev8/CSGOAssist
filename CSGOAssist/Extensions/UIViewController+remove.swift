//
//  UICollectionViewController+remove.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

//MARK: - Added remove() function to UIViewController
extension UIViewController {
    
    func remove() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
