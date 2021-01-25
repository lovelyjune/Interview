//
//  NetModelTests.swift
//  InterviewTests
//
//  Created by june on 2021/1/25.
//

import XCTest
@testable import Interview

class NetModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func test_model$SaveAndGet() throws
    {
        XCTAssertFalse(NetModel.createSaveAllModelArr(modelArr: nil))
        
        XCTAssertTrue(NetModel.createSaveAllModelArr(modelArr: []))
        
        let newModel = NetModel()
        newModel.modelId = "123"
        let modelArr = [newModel]
        NetModel.createSaveAllModelArr(modelArr: modelArr)
        
        if let oldModelArr = NetModel.getLocalModelArr()
        {
            XCTAssert(oldModelArr.count > 0)
            
            let oldModel = oldModelArr[0]
            XCTAssertEqual(newModel.modelId, oldModel.modelId)
        }
        else
        {
            XCTFail()
        }
    }
    
    func test_model$DelAndGet() throws
    {
        var allModelArr = [NetModel]()

        for _ in 0 ..< 10
        {
            let model = NetModel()
            model.modelId = UUID().uuidString
            allModelArr.append(model)
        }
        NetModel.createSaveAllModelArr(modelArr: allModelArr)
        NetModel.removeLocalModelArr()
        if let oldModelArr = NetModel.getLocalModelArr()
        {
            if oldModelArr.count > 0
            {
                XCTFail()
            }
        }
        else
        {
            XCTFail()
        }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
