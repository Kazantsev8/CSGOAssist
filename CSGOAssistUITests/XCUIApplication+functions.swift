//
//  XCUIApplication+functions.swift
//  CSGOAssistUITests
//
//  Created by Иван Казанцев on 30.07.2021.
//

import XCTest

extension XCUIApplication {
    
    func buttonCSGO() -> XCUIElement {
        return self.buttons["CSGO 80x80transparent"]
    }
    
}
