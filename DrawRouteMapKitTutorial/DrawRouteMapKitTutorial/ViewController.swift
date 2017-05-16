//
//  ViewController.swift
//  DrawRouteMapKitTutorial
//
//  Created by 黎明 on 2017/5/12.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var gotoButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var loactionManager = CLLocationManager()
    
    lazy var geoCoder = CLGeocoder()
    
    var sourceCoordinate: CLLocationCoordinate2D?
    var destationCoordinate: CLLocationCoordinate2D?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loactionManager.delegate = self
        
        if loactionManager.responds(to: #selector(loactionManager.requestAlwaysAuthorization)) {
            
            loactionManager.requestAlwaysAuthorization()
        }
        loactionManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.userTrackingMode = .follow
        
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(annotationGRAction(tapGR:)))
        mapView.addGestureRecognizer(tapGR)
        
    }
    
    @objc private func annotationGRAction(tapGR: UITapGestureRecognizer) {
        
        gotoButton.isHidden = false
        
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        let overlys = mapView.overlays
        mapView.removeOverlays(overlys)
        
        
        let tapPoint = tapGR.location(in: mapView)
        let tapCoordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        destationCoordinate = tapCoordinate
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = tapCoordinate
        self.mapView.showAnnotations([annotation], animated: true)
        
        
        
        
        
        
//        let location = CLLocation.init(latitude: tapCoordinate.latitude, longitude: tapCoordinate.longitude)
//        geoCoder.reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in
//            let placemark = placemarks?.first
//            if let tmpPlacemark = placemark {
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = tapCoordinate
//                annotation.title = tmpPlacemark.locality
//                annotation.subtitle = tmpPlacemark.name
//                self.mapView.showAnnotations([annotation], animated: true)
//                
//                print("locationCity: \(tmpPlacemark.locality!), locationName: \(tmpPlacemark.name!)")
//            }
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let _ = location {
            print("location: (\(location!.coordinate.longitude), \(location!.coordinate.latitude))")
        }
        
//        manager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let location = userLocation.location {
            mapView.setCenter(location.coordinate, animated: true)
            
            sourceCoordinate = location.coordinate
            
            
            print("sourceLoaction: (\(sourceCoordinate!.longitude), \(sourceCoordinate!.latitude))")
            
//            let center = location.coordinate
//            let span = MKCoordinateSpanMake(0.077979, 0.044529)
//            let region = MKCoordinateRegionMake(center, span)
//            mapView.setRegion(region, animated: true)
            
        }
    }
    
    @IBAction func gotoButtonAction(_ sender: UIButton) {
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate!, addressDictionary: nil)
        let destanstionPalcemark = MKPlacemark.init(coordinate: destationCoordinate!, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destanstionMapItem = MKMapItem(placemark: destanstionPalcemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destanstionMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [unowned self] (response, error) in
            guard let tmpResponse = response else {
                return
            }
            
            let route = tmpResponse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 4
        
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

