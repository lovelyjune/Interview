//
//  InterviewUITests.swift
//  InterviewUITests
//
//  Created by june on 2021/1/22.
//

import XCTest

class InterviewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let exp = self.expectation(description: "aaa")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) { [weak self] in
            if let _ = self
            {
                let newBtn = app.buttons.staticTexts["to newest"]
                newBtn.tap()

                XCTAssert(app.tables.cells.count > 0)
            }
            else
            {
                XCTFail()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 14.0) { [weak self] in
            if let _ = self
            {
                let clearBtn = app.buttons.staticTexts["clear all"]
                clearBtn.tap()

                XCTAssertEqual(app.tables.cells.count, 0)
                
                exp.fulfill()
            }
            else
            {
                XCTFail()
            }
        }
        
        self.waitForExpectations(timeout: 20.0) { (error) in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
