//
//  TrafficLightsUITests.swift
//  TrafficLightsUITests
//
//  Created by Nick Dawson on 27/07/2016.
//  Copyright © 2016 Nick Dawson. All rights reserved.
//  Updated to Swift 5.0 Xcode 11 iOS 13.0 by Ale111 22/06/2020
//  https://github.com/Ale111
//

import XCTest

class TrafficLightsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
