//
//  TrafficController.swift
//  TrafficLights
//
//  Created by Nick Dawson on 27/07/2016.
//  Copyright © 2016 Nick Dawson. All rights reserved.
//  Updated to Swift 5.0 Xcode 11 iOS 13.0 by Ale111 22/06/2020
//  https://github.com/Ale111
//

import UIKit

enum TrafficLightState {
    case AllRed
    case NorthSouth
    case NorthSouthAmber
    case EastWest
    case EastWestAmber
}

protocol TrafficControllerDelegate {
    func updateState(controller: TrafficController, state: TrafficLightState)
}

class TrafficController: NSObject {
    
    let controllerDelegate: TrafficControllerDelegate
    var running = false
    var trafficLightState = TrafficLightState.AllRed
    var timer: Timer?
    let longDelay = 10
    let shrtDelay = 5
    
    init(delegate: TrafficControllerDelegate) {
        controllerDelegate = delegate
    }
    
    func start() {
        if running {
            return
        }
        
        running = true
        
        changeLights()
    }
    
    func stop() {
        if !running {
            return
        }
        
        running = false
        
        timer?.invalidate()
        
        // Reset to initial state
        updateState(state: .AllRed)
    }
    
    @objc func changeLights() {
        
        var delay: TimeInterval
        
        switch trafficLightState {
        case .AllRed:
            updateState(state: .NorthSouth)
            delay = TimeInterval(longDelay)
            
        case .NorthSouth:
            updateState(state: .NorthSouthAmber)
            delay = TimeInterval(shrtDelay)
            
        case .NorthSouthAmber:
            updateState(state: .EastWest)
            delay = TimeInterval(longDelay)
            
        case .EastWest:
            updateState(state: .EastWestAmber)
            delay = TimeInterval(shrtDelay)
            
        case .EastWestAmber:
            updateState(state: .NorthSouth)
            delay = TimeInterval(longDelay)
        }
        
        // Schedule timer so we're running more operations than we need
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(TrafficController.changeLights), userInfo: nil, repeats: false)
    }
    
    func updateState(state: TrafficLightState) {
        trafficLightState = state
        
        controllerDelegate.updateState(controller: self, state: state)
    }

}
