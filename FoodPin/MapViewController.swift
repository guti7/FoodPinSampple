//
//  MapViewController.swift
//  FoodPin
//
//  Created by Guti on 10/25/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Variables
    var restaurant: Restaurant!
    
    
    // MARK: - Outlets
    // establish connection with the map view in the storyboard
    @IBOutlet var mapView: MKMapView!
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Convert address to coordinate and annotate it on map
        // forward-geocoding
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { placemarks, error in
           
            // error handling
            if error != nil {
                print(error!)
                return
            }
            
            // placemark holds all the data location specifics
            if let placemarks = placemarks {
                // get the first 
                let placemark = placemarks[0]
                
                // create and add an anotataion to the map view from the placemark data
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // diplay annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
        
        mapView.delegate = self
        
        // customize map view
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
    }
    
    
    // MARK: - Map View Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        // annotation.isKind(of: MKUserLocation)
        if annotation is MKUserLocation { return nil }
        
        // reuse the annotation if possible
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?  MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        // customize pin color
        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
