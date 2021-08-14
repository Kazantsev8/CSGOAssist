//
//  MapsPageTestCase.swift
//  CSGOAssistUITests
//
//  Created by Иван Казанцев on 30.07.2021.
//

import XCTest

class MapsPageTestCase: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }
    
    func testButtonCSGO() {
        //act
        clickCSGOButton()
        //assert
        XCTAssert(app.staticTexts["Compatible CS:GO version: v0.1"].exists)
    }




}
