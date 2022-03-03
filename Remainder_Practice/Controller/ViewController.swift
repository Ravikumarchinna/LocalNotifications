//
//  ViewController.swift
//  Remainder_Practice
//
//  Created by Ravikumar on 01/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UNService.shared.authorize()
        CLService.shared.authorize()
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterRegion), name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
    }

    @IBAction func onTimerTapped(){
        
        AlertService.actionSheet(in: self, title: "5 Seconds") {
            UNService.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func onDateTapped(){
        
        AlertService.actionSheet(in: self, title: "Its future time") {
            var components = DateComponents()
            components.second = 0
            UNService.shared.dateRequest(with: components)
        }
    }
    
    @IBAction func onLocatoinTapped(){
        
        AlertService.actionSheet(in: self, title: "When i return") {
            print("Location")
            CLService.shared.updateLocation()
        }
    }
    
    @objc func didEnterRegion(){
        UNService.shared.locationRequest()
    }
    
}






















































