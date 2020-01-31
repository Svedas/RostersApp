//
//  Rosters_AppUITests.swift
//  Rosters AppUITests
//
//  Created by Mantas Svedas on 1/14/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest

class Rosters_AppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {

        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }
    
    func testShowingViews(){
        let isDisplayingMain = app.otherElements["TeamsVC"].exists
        XCTAssertTrue(isDisplayingMain)

        let label = app.tables.staticTexts.firstMatch
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        label.tap()
        
        let isDisplayingSegmented = app.otherElements["SegmentedVC"].exists
        XCTAssertTrue(isDisplayingSegmented)
        let isDisplayingNews = app.otherElements["NewsVC"].exists
        XCTAssertTrue(isDisplayingNews)
        
        app/*@START_MENU_TOKEN@*/.buttons["Players"]/*[[".otherElements[\"SecondVC\"]",".segmentedControls.buttons[\"Players\"]",".buttons[\"Players\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let isDisplayingPlayers = app.otherElements["PlayersVC"].exists
        XCTAssertTrue(isDisplayingPlayers)
        
        app.tables.staticTexts.firstMatch.tap()
        
        let isDisplayingProfile = app.otherElements["ProfileVC"].exists
        XCTAssertTrue(isDisplayingProfile)
    }
    
    func testButtons(){
        
        let label = app.tables.staticTexts.firstMatch
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        label.tap()
        
        let isDisplayingPlayersButton = app.buttons["Players"].exists
        XCTAssertTrue(isDisplayingPlayersButton)
        let isDisplayingNewsButton = app.buttons["News"].exists
        XCTAssertTrue(isDisplayingNewsButton)
        
        let nbaButton = app.navigationBars["Rosters_App.SegmentedView"].buttons["NBA"]
        nbaButton.tap()
        app.tables.staticTexts.firstMatch.tap()
        
        app.buttons["Players"].tap()
        app.buttons["News"].tap()
        app.buttons["Players"].tap()
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
