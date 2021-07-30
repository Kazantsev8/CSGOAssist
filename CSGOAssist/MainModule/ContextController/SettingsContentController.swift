//
//  SettingsContentController.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 28.07.2021.
//

import UIKit

//MARK: - Settings Content Controller
final class SettingsContentController: UIViewController {
    
    //MARK: - Properties
    private var compatibleVersion: String {
        get {
            return CurrentVersion.compatibleVersion ?? "No data"
        }
    }
    
    //MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    lazy var compatibleVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Compatible CS:GO version: \(compatibleVersion)"
        return label
    }()
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Gradient.horizon.colorsUI[1]
        self.view.addSubview(compatibleVersionLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    //MARK: - Constraints
    private lazy var labelConstraints: [NSLayoutConstraint] = {
        return [
            compatibleVersionLabel.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 15),
            compatibleVersionLabel.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                constant: 15),
            compatibleVersionLabel.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -15),
            compatibleVersionLabel.heightAnchor.constraint(
                equalToConstant: 20)
        ]
    }()

}
