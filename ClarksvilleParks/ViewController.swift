//
//  ViewController.swift
//  ClarksvilleParks
//
//  Created by Hannie Kim on 8/14/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var rightBarButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()        
    
    // updates location every time user location is moved
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // most recent position of our user
        let location = locations[0]
        
        // stores the data regarding user's location
//        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        // stops updating the location
        // TODO: // may be an issue when user moves, but it lets the user move the map around to view other annotations
        manager.stopUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getting location of the user
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // set title of nav bar
        title = "Map"
                
        // the park instances
        let london = Parks(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Parks(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Parks(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Parks(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Parks(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        let gisCenter = Parks(title: "APSU GIS Center", coordinate: CLLocationCoordinate2D(latitude: 36.5351, longitude: -87.3606), info: "GIS Center by APSU Campus.")
        let university = Parks(title: "APSU University", coordinate: CLLocationCoordinate2D(latitude: 36.5350, longitude: -87.3549), info: "APSU University")
        
        // add all the annotations to the parks
        mapView.addAnnotations([london, oslo, paris, rome, washington, gisCenter, university])
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // ensure we reuse annotation views as much as possible
        let identifier = "Parks"
        
        // check whether annotation we're creating a view for is a Capital object
        if annotation is Parks {
            // dequeue a annotation view
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            // if there isn't a reusable view
            if annotationView == nil {
                // triggers the popup with the city name
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                // new button with .detailDisclosure
                let btn = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = btn
            } else {
                // if you can reuse a view, update that view to use a different annotation
                annotationView?.annotation = annotation
            }
            // if annotation isn't from a capital city, must return nil so iOS uses default view
            return annotationView
        }
        return nil
    }

    // Info is shown as an alert controller when the callout accessory is pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let parks = view.annotation as! Parks
        let placeName = parks.title
        let placeInfo = parks.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func featureButton(_ sender: UIBarButtonItem) {
        
    }
    
}

