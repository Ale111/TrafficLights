//
//  ViewController.swift
//  TrafficLights
//
//  Created by Nick Dawson on 27/07/2016.
//  Copyright © 2016 Nick Dawson. All rights reserved.
//  Updated to Swift 5.0 Xcode 11 iOS 13.0 by Ale111 22/06/2020
//  https://github.com/Ale111
//

import UIKit

class ViewController: UIViewController, TrafficControllerDelegate {
    
    
    
    @IBOutlet weak var northLights: UIImageView?
    @IBOutlet weak var southLights: UIImageView?
    @IBOutlet weak var eastLights: UIImageView?
    @IBOutlet weak var westLights: UIImageView?
    
    var controller: TrafficController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        controller = TrafficController(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startStopPress(sender: UIButton) {
        if controller!.running {
            controller!.stop()
            
            sender.setTitle("Start", for: .normal)
        } else {
            self.controller!.start()
            
            sender.setTitle("Stop", for: .normal)
        }
    }
    
    func updateState(controller: TrafficController, state: TrafficLightState) {
        print("Update state... State: \(state)")
        switch state {
            case .NorthSouth:
                northLights?.image = UIImage(named: "green")
                southLights?.image = UIImage(named: "green")
                eastLights?.image = UIImage(named: "red")
                westLights?.image = UIImage(named: "red")
            
            case .NorthSouthAmber:
                northLights?.image = UIImage(named: "amber")
                southLights?.image = UIImage(named: "amber")
            
            case .EastWest:
                northLights?.image = UIImage(named: "red")
                southLights?.image = UIImage(named: "red")
                eastLights?.image = UIImage(named: "green")
                westLights?.image = UIImage(named: "green")
            
            case .EastWestAmber:
                eastLights?.image = UIImage(named: "amber")
                westLights?.image = UIImage(named: "amber")
            
            case .AllRed:
                northLights?.image = UIImage(named: "red")
                southLights?.image = UIImage(named: "red")
                eastLights?.image = UIImage(named: "red")
                westLights?.image = UIImage(named: "red")
        }
    }
}

