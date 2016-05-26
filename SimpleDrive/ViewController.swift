//
//  ViewController.swift
//  SimpleDrive
//
//  Created by Andrés Pizá Bückmann on 5/5/16.
//  Copyright © 2016 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let apiService = ApiService()
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        apiService.getAvisos {
            avisos in
            for aviso in avisos {
                self.mapView.addAnnotation(aviso)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLoction: CLLocation = locations[0]
        let latitude = userLoction.coordinate.latitude
        let longitude = userLoction.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.2
        let lonDelta: CLLocationDegrees = 0.2
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
    }
}
