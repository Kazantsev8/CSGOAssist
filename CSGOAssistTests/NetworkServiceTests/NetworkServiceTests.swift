//
//  NetworkServiceTests.swift
//  CSGOAssistTests
//
//  Created by Иван Казанцев on 29.07.2021.
//

import XCTest

class NetworkServiceTests: XCTestCase {

    var sut: NetworkServiceProtocol!
    
    override func setUp() {
        super.setUp()
        sut = NetworkService()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testThatLoadDataReturnsNotNil() {
        //arrange
        let expectation = expectation(description: "loadDataTests")
        //act
        sut.loadData { response in
            switch response {
            case .failure(let error):
                //assert
                XCTAssertNil(error)
            case .success(let maps):
                //assert
                XCTAssertNotNil(maps)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testThatLoadImageReturnsNotNil() {
        //arrange
        let expectation = expectation(description: "loadImageTests")
        let testImageUrl = "https://storage.googleapis.com/csgoassist/mirage.jpg"
        //act
        sut.loadImage(imageUrl: testImageUrl) { response in
            switch response {
            case .failure(let error):
                //assert
                XCTAssertNil(error)
            case .success(let maps):
                //assert
                XCTAssertNotNil(maps)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testThatRequestTimestampReturnsNotNil() {
        //arrange
        let expectation = expectation(description: "requestTimestampTests")
        //act
        sut.requestTimestamp { response in
            switch response {
            case .failure(let error):
                //assert
                XCTAssertNil(error)
            case .success(let timeStamp):
                //assert
                XCTAssertNotNil(timeStamp)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testThatRequestCompatibeVersionReturnsNotNil() {
        //arrange
        let expectation = expectation(description: "requestCompatibleVersionTests")
        //act
        sut.requestCompatibleVersion { response in
            switch response {
            case .failure(let error):
                //assert
                XCTAssertNil(error)
            case .success(let compatibleVersion):
                //assert
                XCTAssertNotNil(compatibleVersion)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    

}
