//
//  StartApplicationOperation.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 03.08.2021.
//

import Foundation

//MARK: - StartApplicationOperation
final class StartApplicationOperation: AsyncOperation {

    private let coordinator: CoordinatorProtocol
    private let _maps: [MapDTO]?

    private var maps: [MapDTO]? {
        var result: [MapDTO]?
        if let maps = _maps {
            result = maps
        } else if let dataProvider = dependencies.filter({ $0 is CoreDataMapsPass}).first as? CoreDataMapsPass {
            result = dataProvider.maps
        }
        return result
    }

    init(coordinator: CoordinatorProtocol, maps: [MapDTO]?) {
        self.coordinator = coordinator
        self._maps = maps
    }

    override func execute() {
        if isCancelled { return }
        coordinator.toMapsContainerController(maps: maps ?? [])
        self.isExecuting = false
        self.isFinished = true
    }

}
