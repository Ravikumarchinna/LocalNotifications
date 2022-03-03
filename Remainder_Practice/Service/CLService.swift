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
    var shouldRegion = true
    
    let locationManager = CLLocationManager()
    
    func authorize()  {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        shouldRegion = true
        locationManager.startUpdatingLocation()
    }
    
    
}


extension CLService:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got locations")
        //... If we want updated location for that we gave the flas shouldRegion
        guard let currentLocation = locations.first,shouldRegion else {return}
        shouldRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter location region")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
    }
}















































































