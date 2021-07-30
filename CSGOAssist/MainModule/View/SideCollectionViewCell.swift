//
//  SideCollectionViewCell.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

final class SideCollectionViewCell: UICollectionViewCell {
    
    //cell reuse identifier
    static let reuseID = String(describing: SideCollectionViewCell.self)
    
    //MARK: - UI
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.autoresizingMask = .flexibleWidth
        label.font = UIFont(name: "Copperplate-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Cell Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        //add subviews
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        //layout subviews
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        //shadow
        configureShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    //MARK: - Constraints
    private lazy var imageConstraints: [NSLayoutConstraint] = {
        return [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
    }()
    
    private lazy var labelConstraints: [NSLayoutConstraint] = {
        return [
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
    }()
    
    //MARK: - Configuration
    private func configureShadow() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: self.layer.cornerRadius).cgPath
    }
    
}
