//
//  ActionsContentController.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

protocol ActionsContentControllerDelegate {
    
    func actionCellTapped(at indexPath: IndexPath, currentSides: [SideDTO])
    
    func leftSwiped()
    
}

//MARK: - Actions Content Controller
final class ActionsContentController: UIViewController {
    
    var delegate: ActionsContentControllerDelegate?
    
    private var actions: [ActionDTO] = []

    //MARK: - Initialization
    init(with actionDTO: [ActionDTO]) {
        self.actions = actionDTO
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Gradient.horizon.colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
    }()
    
    //MARK: - Constraints
    private lazy var tableViewConstraints: [NSLayoutConstraint] = {
        return [
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(actions.count) * 44),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ]
    }()
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //background layer
        self.view.layer.addSublayer(gradientLayer)
        //register cell
        self.tableView.register(ActionTableViewCell.self, forCellReuseIdentifier: ActionTableViewCell.reuseID)
        //gesture recognizer
        configureGestureRecognizer()
        //adding tableview as subview
        self.view.addSubview(tableView)
        self.tableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradientLayer.frame = self.view.bounds
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    //MARK: - Objc Methods
    @objc func close() {
        delegate?.leftSwiped()
    }
    
    //MARK: - Other functions
    func configureGestureRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(close))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
}

//MARK: - Table View Data Source and Delegate Methods
extension ActionsContentController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let actionCell = tableView.dequeueReusableCell(withIdentifier: ActionTableViewCell.reuseID, for: indexPath) as? ActionTableViewCell else {
            fatalError("MapsCollectionViewController.collectionView.cellForItemAt.mapCellFailure")
        }
        actionCell.textLabel?.text = actions[indexPath.row].name
        return actionCell
    }
    
}
