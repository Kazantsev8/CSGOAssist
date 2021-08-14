//
//  CSGOAssistSnapshotTests.swift
//  CSGOAssistSnapshotTests
//
//  Created by Иван Казанцев on 29.07.2021.
//

import XCTest
import SnapshotTesting
@testable import CSGOAssist

class CSGOAssistSnapshotTests: XCTestCase {

    func testMapsContentController() {
        let mapsContentController = MapsContentController(with: [])
        assertSnapshot(matching: mapsContentController, as: .image(on: .iPhone8))
    }
    
    func testSideContentController() {
        let sidesContentController = SidesContentController(with: [])
        assertSnapshot(matching: sidesContentController, as: .image(on: .iPhone8))
    }
    
}
