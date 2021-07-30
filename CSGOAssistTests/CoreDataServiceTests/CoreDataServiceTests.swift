//
//  CoreDataServiceTests.swift
//  CSGOAssistTests
//
//  Created by Иван Казанцев on 29.07.2021.
//

import XCTest
import CoreData

class CoreDataServiceTests: XCTestCase {
    
    var maps: [MapDTO] = []

    var sut: CoreDataServiceProtocol!
    var stack = MockCoreDataStack()
    
    override func setUp() {
        super.setUp()
        sut = CoreDataService(coreDataStack: stack)
        
        let article = ArticleDTO(text: "test", imageUrl: "test")
        let topic = TopicDTO(header: "test", description: [article])
        let action = ActionDTO(name: "test", imageUrl: "test", topics: [topic])
        let side = SideDTO(name: "test", imageUrl: "test", actions: [action])
        let map = MapDTO(name: "test", imageUrl: "test", sides: [side])
        
        maps = [map]
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testThatMapsWritesToCoreData() {
        //arrange
        let expectationResult: [MapDTO] = maps
        //act
        sut.writeMaps(with: maps)
        let result = sut.readMaps()
        //assert
        XCTAssertEqual(expectationResult, result)
    }
    
    func testThatMapsIsDeletedFromCoreData() {
        //arrange
        let expectationResult: [MapDTO] = []
        //act
        sut.clearStorage()
        let result = sut.readMaps()
        //assert
        XCTAssertEqual(expectationResult, result)
    }
    
    

}
