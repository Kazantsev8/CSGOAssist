//
//  LoadViewController.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 02.07.2021.
//

import UIKit

//MARK: - Load View Controller 
final class LoadViewController: UIViewController {
    
    //MARK: - Private Properties
    private var coordinator: CoordinatorProtocol
    private var updateFlow: UpdateFlowProtocol

    //MARK: - Initialization
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        self.updateFlow = UpdateFlow(coordinator: coordinator)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - User Interface
    lazy var loadingAnimationView: LoadingAnimationView = {
        let view = LoadingAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loadingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "checking for an update"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Gradient.horizon.colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
    }()
    
    //MARK: - Layout Subviews
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 100.0),
            loadingAnimationView.widthAnchor.constraint(equalToConstant: 100.0),
        ])
        NSLayoutConstraint.activate([
            loadingTextLabel.topAnchor.constraint(equalTo: loadingAnimationView.bottomAnchor, constant: 30),
            loadingTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingTextLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
        
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.navigationController?.navigationBar.isHidden = true
        view.layer.addSublayer(gradientLayer)
        view.addSubview(loadingAnimationView)
        view.addSubview(loadingTextLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradientLayer.frame = view.bounds
        loadingAnimationView.animate()
        self.updateFlow.checkState()
        self.updateFlow.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingAnimationView.stopAnimate()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

}
