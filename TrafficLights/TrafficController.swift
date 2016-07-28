//
//  TrafficController.swift
//  TrafficLights
//
//  Created by Nick Dawson on 27/07/2016.
//  Copyright © 2016 Nick Dawson. All rights reserved.
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
    var timer: NSTimer?
    
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
        updateState(.AllRed)
    }
    
    func changeLights() {
        
        var delay: NSTimeInterval
        
        switch trafficLightState {
        case .AllRed:
            updateState(.NorthSouth)
            delay = 25
            
        case .NorthSouth:
            updateState(.NorthSouthAmber)
            delay = 5
            
        case .NorthSouthAmber:
            updateState(.EastWest)
            delay = 25
            
        case .EastWest:
            updateState(.EastWestAmber)
            delay = 5
            
        case .EastWestAmber:
            updateState(.NorthSouth)
            delay = 25
        }
        
        // Schedule timer so we're running more operations than we need
        timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(TrafficController.changeLights), userInfo: nil, repeats: false)
    }
    
    func updateState(state: TrafficLightState) {
        trafficLightState = state
        
        controllerDelegate.updateState(self, state: state)
    }

}
