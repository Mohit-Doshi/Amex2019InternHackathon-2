//
//  FindPoolViewController.swift
//  FindAPool
//
//  Created by Mohit Doshi on 8/8/19.
//  Copyright © 2019 forty-two. All rights reserved.
//

import UIKit
import MapKit

class FindPoolViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let choices = ["AEDR","TRC-N/TRC-W","Tempe","AESC"]
    var choice:String = "default"
    var obj:CallsToMaps?
    var routes:[CurrentRoutes]?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choice = String(choices[row])
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    var sentName:String = "default"
    @IBOutlet weak var AddressField: UITextField!
    
    @IBOutlet weak var TimeField: UITextField!
    @IBOutlet weak var WelcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        WelcomeLabel.text = "Welcome \(sentName)"
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        obj = CallsToMaps() // constructor
    }
    
    func retcoordinates(cityaddr: String, completionHandler: @escaping (CLLocationCoordinate2D) -> Void)
    {
        //print("I am at the beginning of the function")
        var coords:CLLocationCoordinate2D?
        let geoCoder = CLGeocoder();
        CLGeocoder().geocodeAddressString(cityaddr, completionHandler:
            {(placemarks, error) in
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    coords = location!.coordinate
                    print(location!)
                    print("COORDINATES : ", coords!)
                    completionHandler(coords!)
                    // return coords
                }
                
        })
    }

    @IBAction func GenerateRoutes(_ sender: UIButton) {
        
        print("\n\n\n\nThis is the json:  \(obj?.jsonResult)\n\n\n\n")
        
        retcoordinates(cityaddr: AddressField.text!){ (cdnates) in
            self.routes = self.obj?.themcalls(address: cdnates, ti: Float(self.TimeField.text!) as! Float, de: self.choice)
        }
        print("\n\n\n\nImmediately: ")
                }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

          let obj = segue.destination as! CarpoolsViewController
        obj.sentClass = routes!
        
    }
    

}
