//
//  MapViewController.swift
//  Show & Tell
//
//  Created by Tom Wicks on 06/04/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit
import CloudKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var crumbPath: CrumbPath?
    var crumbPathRenderer: CrumbPathRenderer?
    
    @IBAction func centreOnUser(sender: AnyObject) {
        mapView.userTrackingMode = .Follow
    }
    
    @IBAction func sendMyLocation(sender: AnyObject) {
        let alert = UIAlertController(title: "New Sweet", message: "Enter a sweet", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            textField.placeholder = "Your sweet"
        }
        
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first!
            
            if textField.text != "" {
                let newSweet = CKRecord(recordType: "Sweet")
                newSweet["content"] = textField.text
                
                let publicData = CKContainer.defaultContainer().publicCloudDatabase
                publicData.saveRecord(newSweet, completionHandler: { (record:CKRecord?, error:NSError?) -> Void in
                    if error == nil {
                        print("woo")
                    }else{
                        print(error)
                    }
                })
                
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define Navigation Styles
        
        let navigationStyle = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: UIFont(name: "GT Walsheim", size: 16)!
        ]
        
        // Remove Shadow!
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        // Initialise Navigation Styles
        
        self.navigationController?.navigationBar.titleTextAttributes = navigationStyle
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5.0
        self.locationManager.startUpdatingLocation()
        self.mapView.delegate = self
        self.mapView.userTrackingMode = .Follow
        self.mapView.showsUserLocation = true
    }
    
    func addCrumbPoint(point:CLLocationCoordinate2D) {
        
        if let _ = crumbPath {
            
            //var boundingMapRectChanged = false
            crumbPath!.addCoordinate(point)
            
            mapView.removeOverlay(crumbPath!)
            crumbPathRenderer = nil
            mapView.addOverlay(crumbPath!)
            
        }
        else {
            crumbPath = CrumbPath(centerCoordinate:point)
            mapView.addOverlay(crumbPath!)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay.isKindOfClass(CrumbPath)) {
            if let _ = crumbPathRenderer {
            }
            else {
                crumbPathRenderer = CrumbPathRenderer(overlay:overlay)
            }
            return crumbPathRenderer!
        }
        return MKTileOverlayRenderer(overlay: overlay)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        addCrumbPoint(center)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
