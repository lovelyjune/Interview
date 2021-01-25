//
//  ApiRequestManagerTests.swift
//  InterviewTests
//
//  Created by june on 2021/1/25.
//

import XCTest
import XCTest
@testable import Interview

class ApiRequestManagerTests: XCTestCase {

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
    
    func test_GetRequest() throws
    {
        let exp = self.expectation(description: "这个请求太慢了，有异常")
        
        ApiRequestManager.shared.GetRequest(url: "https://api.github.com", parameterDict: nil) { (resultDict) in
            if let resultDict = resultDict
            {
                exp.fulfill()
            }
            else
            {
                XCTFail()
            }
        } failure: { (error) in
            XCTFail(error.debugDescription)
        }
        
        self.waitForExpectations(timeout: 5.0) { (error) in
            if let error = error
            {
                XCTFail(exp.description)
                XCTFail(error.localizedDescription)
            }
        }

    }
    
    func test_stringValueDic() throws
    {
        var resultDict = ApiRequestManager.shared.stringValueDic("")
        XCTAssertNil(resultDict)
        
        resultDict = ApiRequestManager.shared.stringValueDic("{\"name\":\"joy\",\"age\":22}")
        XCTAssertNotNil(resultDict)
        if let resultDict = resultDict
        {
            if let name = resultDict["name"] as? String
            {
                XCTAssertEqual("joy", name)
            }
            else
            {
                XCTFail()
            }
            if let age = resultDict["age"] as? Int
            {
                XCTAssertEqual(22, age)
            }
            else
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
