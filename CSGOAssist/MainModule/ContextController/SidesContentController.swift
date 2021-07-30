//
//  SidesContentController.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

protocol SidesContentControllerDelegate {
    
    func sideCellTapped(at indexPath: IndexPath, currentSides: [SideDTO])
    
    func backToMapsButtonTapped()
    
    func loadImage(urlSide: String, completion: @escaping (Data) -> ())
    
}

//MARK: - Sides Content Controller (to display sides in MapContainterController
final class SidesContentController: UICollectionViewController {
    
    ///Delegate for data transfering and routing methods
    var delegate: SidesContentControllerDelegate?
    
    private var sides: [SideDTO]
    
    //MARK: - Initialization
    init(with sideDTO: [SideDTO]) {
        self.sides = sideDTO
        super.init(collectionViewLayout: UICollectionViewLayout())
        self.collectionView.register(SideCollectionViewCell.self,
                                     forCellWithReuseIdentifier: SideCollectionViewCell.reuseID)
        self.collectionView.collectionViewLayout = createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Maps.png")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = Gradient.horizon.colorsUI[1]
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 50
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Gradient.horizon.colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
    }()

    private lazy var backButtonConstraints: [NSLayoutConstraint] = {
        return [
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 100),
            backButton.widthAnchor.constraint(equalToConstant: 100)
        ]
    }()
    
    //MARK: - View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = Gradient.horizon.colorsUI.first
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.view.addSubview(backButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradientLayer.frame = collectionView.bounds
        self.collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate(backButtonConstraints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    private func createLayout() -> UICollectionViewLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 30, bottom: 30, trailing: 30)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .horizontal
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            layout.configuration = config
            
            return layout
    }

}

//MARK: - Collection View Data Source and Delegate Methods
extension SidesContentController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sides.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sideCell = collectionView.dequeueReusableCell(withReuseIdentifier: SideCollectionViewCell.reuseID, for: indexPath) as? SideCollectionViewCell else {
            fatalError("MapsCollectionViewController.collectionView.cellForItemAt.mapCellFailure")
        }
        
        if let url = self.sides[indexPath.row].imageUrl {
            self.delegate?.loadImage(urlSide: url, completion: { data in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    sideCell.imageView.image = image
                }
            })
        }
        
        sideCell.label.text = self.sides[indexPath.row].name
        return sideCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.sideCellTapped(at: indexPath, currentSides: self.sides)
    }
    
    @objc func close() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
            self.backButton.transform = .init(scaleX: 0.9, y: 0.9)
                       }, completion: { finished in
            self.delegate?.backToMapsButtonTapped()
                       })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
            self.backButton.transform = .init(scaleX: 1, y: 1)
                       })
    }
    
}
