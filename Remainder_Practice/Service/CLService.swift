//
//  CLService.swift
//  Remainder_Practice
//
//  Created by Ravikumar on 03/03/22.
//

import Foundation
import CoreLocation

class CLService: NSObject {
    
    private override init(){}
    static let shared = CLService()
    
    let locationManager = CLLocationManager()
    
    func authorize()  {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    
}


extension CLService:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got locations")
    }
}















































































