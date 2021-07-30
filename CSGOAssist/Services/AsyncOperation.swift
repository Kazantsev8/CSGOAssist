//
//  AsyncOperation.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 21.07.2021.
//

import Foundation

class AsyncOperation: Operation {
    
    ///This operation is for asynchronous usage
    override var isAsynchronous: Bool {
        return true
    }
    ///Overriden states for using this operation asynchronouds
    var _isFinished: Bool = false
    override var isFinished: Bool {
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
        get {
            return _isFinished
        }
    }

    var _isExecuting: Bool = false
    override var isExecuting: Bool {
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
        get {
            return _isExecuting
        }
    }
    
    //MARK: - This function needs for override her
    func execute() {
        
    }
    
    override func start() {
        isExecuting = true
        execute()
    }
    
    override func cancel() {
        super.cancel()
        self.isFinished = true
    }
    
}

