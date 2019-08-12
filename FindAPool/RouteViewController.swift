//
//  RouteViewController.swift
//  FindAPool
//
//  Created by Mohit on 08/08/19.
//  Copyright © 2019 forty-two. All rights reserved.
//

import UIKit
import MapKit

class RouteViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mpview: MKMapView!
    
    var mainobj:CurrentRoutes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var coords:CLLocationCoordinate2D?
        coords!.latitude = mainobj!.lato
        coords!.longitude = mainobj!.lono
        print(mainobj!.lato)
        print(mainobj!.lono)
        
        
        // Do any additional setup after loading the view.
        let span = MKCoordinateSpan(latitudeDelta: 30.00, longitudeDelta: 30.00)
        let region = MKCoordinateRegion(center: coords!, span: span)
        self.mpview.setRegion(region, animated: true)
        
        let ani = MKPointAnnotation()
        ani.coordinate = coords!
        ani.title = "Origin"
        self.mpview.addAnnotation(ani)
        
        coords!.latitude = mainobj!.latd
        coords!.longitude = mainobj!.lond
        ani.coordinate = coords!
        ani.title = "Origin"
        self.mpview.addAnnotation(ani)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
