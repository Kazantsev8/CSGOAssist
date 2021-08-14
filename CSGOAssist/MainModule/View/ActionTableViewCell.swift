//
//  ActionTableViewCell.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

final class ActionTableViewCell: UITableViewCell {
    
    //cell reuse identifier
    static let reuseID = String(describing: ActionTableViewCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Gradient.horizon.colorsUI.first
        self.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

