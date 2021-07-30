//
//  ViewController.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 19.06.2021.
//

import UIKit

protocol MapsContextControllerDelegate {
    
    func settingsButtonTapped()
    
    func mapCellTapped(at indexPath: IndexPath)
    
    func loadImage(urlMaps: String, completion: @escaping (Data) -> ())
    
}

//MARK: - Maps Content Controller (to display maps in MapsContainerController)
final class MapsContentController: UICollectionViewController {
    
    ///Delegate for data transfering and routing methods
    var delegate: MapsContextControllerDelegate?
    
    private var maps: [MapDTO]
    
    //MARK: - Initialization
    init(with mapsDTO: [MapDTO]) {
        self.maps = mapsDTO
        super.init(collectionViewLayout: UICollectionViewLayout())
        self.collectionView.register(MapCollectionViewCell.self,
                                     forCellWithReuseIdentifier: MapCollectionViewCell.reuseID)
        self.navigationController?.navigationBar.isHidden = false
        self.collectionView.collectionViewLayout = createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "CSGO_80x80transparent")
        button.setImage(image, for: .normal)
        button.setImage(image, for: .selected)
        button.tintColor = Gradient.horizon.colorsUI[1]
        button.backgroundColor = .clear
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Gradient.horizon.colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
    }()
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = Gradient.horizon.colorsUI.first
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.view.addSubview(settingsButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradientLayer.frame = view.bounds
        self.collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate(settingsButtonConstraints)
    }
    
    //MARK: - Constraints
    private lazy var settingsButtonConstraints: [NSLayoutConstraint] = {
        return [
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsButton.heightAnchor.constraint(equalToConstant: 100),
            settingsButton.widthAnchor.constraint(equalToConstant: 100)
        ]
    }()
    
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
    
    @objc func settingsButtonTapped() {
        delegate?.settingsButtonTapped()
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
            self.settingsButton.transform = .init(scaleX: 0.9, y: 0.9)
        })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
            self.settingsButton.transform = .init(scaleX: 1, y: 1)
        })
    }
    
}

//MARK: - Collection View Data Source & Collection View Delegate Methods
extension MapsContentController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mapCell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.reuseID, for: indexPath) as? MapCollectionViewCell else {
            fatalError("MapsCollectionViewController.collectionView.cellForItemAt.mapCellFailure")
        }
        if let url = self.maps[indexPath.item].imageUrl {
            delegate?.loadImage(urlMaps: url,completion: { data in
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        mapCell.imageView.image = image
                    }
                }
            })
        }
        mapCell.label.text = self.maps[indexPath.item].name
        return mapCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.mapCellTapped(at: indexPath)
    }
    
}



