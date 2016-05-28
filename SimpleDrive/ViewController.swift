//
//  ViewController.swift
//  SimpleDrive
//
//  Created by Andrés Pizá Bückmann on 5/5/16.
//  Copyright © 2016 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let apiService = ApiService()
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        fetchAvisos("2")
    }
    
    private func removeAllPins() {
        mapView.annotations.forEach {
            if !($0 is MKUserLocation) {
                self.mapView.removeAnnotation($0)
            }
        }
    }
    
    func fetchAvisos(horas: String) {
        
        removeAllPins()
        
        apiService.getAvisos(horas) {
            avisos in
            for aviso in avisos {
                self.mapView.addAnnotation(aviso)
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func didChangeValue(sender: UISlider) {
        let hours = String(sender.value).stringByReplacingOccurrencesOfString(".", withString: ",")
        label.text = hours
        
        fetchAvisos(hours)
    }
    
    @IBAction func didTapCenterOnUser(sender: UIButton) {
        if mapView.userLocation.coordinate.latitude != 0.0 && mapView.userLocation.coordinate.longitude != 0.0 {
            let latitude = mapView.userLocation.coordinate.latitude
            let longitude =  mapView.userLocation.coordinate.longitude
            let latDelta: CLLocationDegrees = 0.2
            let lonDelta: CLLocationDegrees = 0.2
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
        }
        else {
            pinView?.annotation = annotation
        }
        
        if let aviso = annotation as? Aviso {
            
            switch aviso.type {
            case .AVISO:
                pinView?.pinTintColor = UIColor.yellowColor()
            case .CONTROL:
                pinView?.pinTintColor = UIColor.blueColor()
            case .RADAR:
                pinView?.pinTintColor = UIColor.redColor()
            default:
                pinView?.pinTintColor = UIColor.orangeColor()
            }
        }
        
        return pinView
    }
}
