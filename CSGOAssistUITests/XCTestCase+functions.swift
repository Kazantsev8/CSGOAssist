//
//  XCTestCase+functions.swift
//  CSGOAssistUITests
//
//  Created by Иван Казанцев on 30.07.2021.
//

import XCTest

extension XCTestCase {
    
    func clickCSGOButton() {
        let buttonCSGO = XCUIApplication().buttonCSGO()
        buttonCSGO.tap()
    }
    
}
