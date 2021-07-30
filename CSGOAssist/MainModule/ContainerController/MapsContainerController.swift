//
//  MapsContainerController.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 25.07.2021.
//

import UIKit

typealias MapsContentControllerProtocol = MapsContextControllerDelegate
typealias SidesContentControllerProtocol = SidesContentControllerDelegate
typealias ActionsContentControllerProtocol = ActionsContentControllerDelegate

//MARK: - Container Controller for Main Module
final class MapsContainerController: UIViewController {
    
    //MARK: - Private Properties
    ///Coordinator controller
    private let coordinator: CoordinatorProtocol
    ///Core Data Service
    private let coreDataService: CoreDataServiceProtocol
    ///Network Service
    private let networkService: NetworkServiceProtocol
    
    private var settingsVC: SettingsContentController?
    private var isMoved: Bool = false
    ///Child Controller who contains Maps
    private var mapsCVC: MapsContentController?
    ///Child Controller who contains Sides
    private var sidesCVC: SidesContentController?
    ///Child Controller who contains Actions
    private var actionsTVC: ActionsContentController?
    
    //Model
    ///DTO model for transfering to mapsCVC data source
    private var maps: [MapDTO] = []
    
    //MARK: - Initialization
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.coreDataService = coordinator.serviceLocator.coreDataSerivce
        self.networkService = coordinator.serviceLocator.networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maps = coreDataService.readMaps()
        configureMapsCVC()
    }
    
}

//MARK: - Maps Content Controller Protocol
extension MapsContainerController: MapsContentControllerProtocol {
    
    //Protocol requirements
    func loadImage(urlMaps: String, completion: @escaping (Data) -> ()) {
        self.networkService.loadImage(imageUrl: urlMaps) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                completion(data)
            }
        }
    }
    
    func mapCellTapped(at indexPath: IndexPath) {
        guard let sides = maps[indexPath.row].sides else { return }
        configureSidesCVC(with: sides)
    }
    
    func settingsButtonTapped() {
        configureSettingsVC()
    }
    
    //Functions
    private func configureMapsCVC() {
        if mapsCVC == nil {
            mapsCVC = MapsContentController(with: maps)
            mapsCVC?.delegate = self
            mapsCVC?.add(in: self)
        }
    }
    
}

//MARK: - Sides Content Controller Protocol
extension MapsContainerController: SidesContentControllerProtocol {
    
    //Protocol requirements
    func loadImage(urlSide: String, completion: @escaping (Data) -> ()) {
        self.networkService.loadImage(imageUrl: urlSide) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                completion(data)
            }
        }
    }
    
    func backToMapsButtonTapped() {
        sidesCVC?.remove()
        sidesCVC = nil
        configureMapsCVC()
    }
    
    func sideCellTapped(at indexPath: IndexPath, currentSides: [SideDTO]) {
        guard let actions = currentSides[indexPath.item].actions else { return }
        configureActionsTVC(with: actions)
    }
    
    //Functions
    private func configureSidesCVC(with sideDTO: [SideDTO]) {
        if sidesCVC == nil {
            sidesCVC = SidesContentController(with: sideDTO)
            sidesCVC?.delegate = self
            sidesCVC?.add(in: self)
        }
    }
    
}

//MARK: - Actions Content Controller Protocol
extension MapsContainerController: ActionsContentControllerProtocol {
    
    //Protocol Requirements
    func actionCellTapped(at indexPath: IndexPath, currentSides: [SideDTO]) {
        
    }
    
    func leftSwiped() {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) {
            guard let actionsVC = self.actionsTVC else { return }
            actionsVC.view.frame.origin.x = actionsVC.view.frame.width
        } completion: { finished in
            self.actionsTVC?.remove()
            self.actionsTVC = nil
        }
        
    }
    
    //Functions
    private func configureActionsTVC(with actionDTO: [ActionDTO]) {
        if actionsTVC == nil {
            actionsTVC = ActionsContentController(with: actionDTO)
            actionsTVC?.delegate = self
            actionsTVC?.add(in: self)
        }
    }
    
}

//MARK: - Settings Content Controller
extension MapsContainerController {
    
    func configureSettingsVC() {
        switch isMoved {
        case false:
            self.settingsVC = SettingsContentController()
            self.settingsVC?.add(in: self)
            self.view.insertSubview((self.settingsVC?.view)!, at: 0)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                guard let mapsVC = self.mapsCVC else { return }
                mapsVC.view.frame.origin.x = mapsVC.view.frame.width * 4/5
            } completion: { finished in
                self.mapsCVC?.collectionView.isUserInteractionEnabled = false
            }
            self.isMoved = true
            break
        case true:
            mapsCVC?.collectionView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                guard let mapsVC = self.mapsCVC else { return }
                mapsVC.view.frame.origin.x = 0
            } completion: { finished in
                self.settingsVC?.remove()
                self.settingsVC = nil
            }
            self.isMoved = false
            break
        }
    }
    
}
