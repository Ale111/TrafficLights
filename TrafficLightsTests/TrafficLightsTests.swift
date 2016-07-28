//
//  TrafficLightsTests.swift
//  TrafficLightsTests
//
//  Created by Nick Dawson on 27/07/2016.
//  Copyright © 2016 Nick Dawson. All rights reserved.
//

import XCTest
@testable import TrafficLights

class TrafficLightsTests: XCTestCase, TrafficControllerDelegate {
    
    var timingTargetState: TrafficLightState?
    var previousState: TrafficLightState?
    var timingExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLightsInitialState() {
        let controller = TrafficController(delegate: self)
        
        XCTAssert(controller.running == false, "Lights shouldn't be running straight away")
        XCTAssert(controller.trafficLightState == .AllRed, "State isn't the previous state to North - South")
    }
    
    func testChangeLights() {
        let controller = TrafficController(delegate: self)
        
        changeFromState(.AllRed, controller: controller)
        changeFromState(.EastWest, controller: controller)
        changeFromState(.EastWestAmber, controller: controller)
        changeFromState(.NorthSouth, controller: controller)
        changeFromState(.NorthSouthAmber, controller: controller)
    }
    
    func testLightsSequence() {
        let controller = TrafficController(delegate: self)
        
        XCTAssert(controller.trafficLightState == .AllRed, "State isn't the previous state to North - South")
        
        controller.changeLights()
        
        XCTAssert(controller.trafficLightState == .NorthSouth, "State isn't North South. Order failed.");
        
        controller.changeLights()
        
        XCTAssert(controller.trafficLightState == .NorthSouthAmber, "State isn't North South Amber. Order failed.");
        
        controller.changeLights()
        
        XCTAssert(controller.trafficLightState == .EastWest, "State isn't East West. Order failed.");
        
        controller.changeLights()
        
        XCTAssert(controller.trafficLightState == .EastWestAmber, "State isn't East West Amber. Order failed.");
        
        controller.changeLights()
        
        XCTAssert(controller.trafficLightState == .NorthSouth, "State isn't North South. Order failed.");
    }
    
    func testStartLights() {
        let controller = TrafficController(delegate: self)
        
        controller.start()
        
        XCTAssert(controller.running == true, "Controller doesn't identify with its actual binary state")
        XCTAssert(controller.trafficLightState == .NorthSouth, "Controller didn't run changeLights() on start")
        XCTAssert(controller.timer != nil, "Controller stopped taking care of it self. Does it not even care any more?")
    }
    
    func testStopLights() {
        let controller = TrafficController(delegate: self)
        
        controller.start()
        
        XCTAssert(controller.running == true, "Controller didn't even start")
        
        controller.stop()
        
        XCTAssert(controller.running == false, "Controller didn't stop. Run Forrest Run")
        XCTAssert(controller.timer?.valid == false, "Timer didn't get invalidate")
    }
    
    func testTiming() {
        let controller = TrafficController(delegate: self)
        
        timingExpectation = expectationWithDescription("Timing expectation")
        timingTargetState = .NorthSouthAmber
        
        controller.start()
        
        waitForExpectationsWithTimeout(26.0) { error in
            
        }
    }
    
    func changeFromState(state: TrafficLightState, controller: TrafficController) {
        self.previousState = state
        controller.trafficLightState = state
        controller.changeLights()
    }
    
    func updateState(controller: TrafficController, state: TrafficLightState) {
        if let oldState = self.previousState {
            switch oldState {
            case .EastWest:
                XCTAssert(controller.trafficLightState == .EastWestAmber, "East West Amber follows East West. Fail.")
                XCTAssert(state == .EastWestAmber, "East West Amber follows East West. Fail.")
                
            case .EastWestAmber:
                XCTAssert(controller.trafficLightState == .NorthSouth, "North South follows East West Amber. Fail.")
                XCTAssert(state == .NorthSouth, "North South follows East West Amber. Fail.")
                
            case .NorthSouth:
                XCTAssert(controller.trafficLightState == .NorthSouthAmber, "North South Amber follows North South. Fail.")
                XCTAssert(state == .NorthSouthAmber, "North South Amber follows North South. Fail.")
                
            case .NorthSouthAmber:
                XCTAssert(controller.trafficLightState == .EastWest, "East West follows North South Amber. Fail.")
                XCTAssert(state == .EastWest, "East West follows North South Amber. Fail.")
                
            case .AllRed:
                XCTAssert(controller.trafficLightState == .NorthSouth, "North South follows All Red. Fail.")
                XCTAssert(state == .NorthSouth, "North South follows All Red. Fail.")
            }
            
            previousState = nil
        }
        
        if let timingState = timingTargetState {
            if state == timingState {
                timingExpectation?.fulfill()
            }
            
            timingTargetState = nil
        }
    }
    
}
