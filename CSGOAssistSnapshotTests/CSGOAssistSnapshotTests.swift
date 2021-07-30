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
        let maps: [MapDTO] = []
        let mapsContentController = MapsContentController(with: maps)
        assertSnapshot(matching: mapsContentController, as: .image(on: .iPhoneSe))
    }
    
}
