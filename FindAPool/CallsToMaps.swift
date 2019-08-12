//
//  CallsToMaps.swift
//  FindAPool
//
//  Created by Mohit Doshi on 8/8/19.
//  Copyright © 2019 forty-two. All rights reserved.
//

import Foundation
import MapKit

class CurrentRoutes {
    var lato:CLLocationDegrees = 0.0
    var lono:CLLocationDegrees = 0.0
    var latd:CLLocationDegrees = 0.0
    var lond:CLLocationDegrees = 0.0
    var name:String = "Jeff"
    var reachingtime:Float = 0.00
    var distanceofcarpool:String?
    var durationofcarpool:String?
    
    init( l:CLLocationDegrees, ll:CLLocationDegrees, lll:CLLocationDegrees, llll:CLLocationDegrees, n:String, r:Float) {
        lato = l
        lono = ll
        latd = lll
        lond = llll
        name = n
        reachingtime = r
    }
}

class CallsToMaps {
    
    var drivers = [CurrentRoutes]()
    var url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=";
    var jsonResult = [NSDictionary]()

    
    init(){
        // make api calls
        drivers.append(CurrentRoutes(l: 33.4152, ll: -111.8315, lll: 33.6584628, llll: -111.965028, n: "Jeff", r: 9.0))
        drivers.append(CurrentRoutes(l: 33.4942, ll: -111.9261, lll: 33.6642, llll: -112.1296936, n: "Marc", r: 9.0))
        drivers.append(CurrentRoutes(l: 33.3737531, ll:-112.1132271, lll: 33.6584628, llll: -111.965028, n: "Diego", r: 8.5))
        drivers.append(CurrentRoutes(l: 33.6693746,ll: -112.5250224, lll: 33.6642, llll: -112.1296936, n: "Rohan", r: 7.0))
        drivers.append(CurrentRoutes(l: 33.3523261,ll: -112.5586023, lll: 33.6584628, llll: -111.965028, n: "James", r: 10.0))
        for driver in drivers {
            let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
            var dataTask: URLSessionDataTask?
            var serveurl = url + "\(driver.lato),\(driver.lono)&destinations=\(driver.latd)%2C\(driver.lond)&key="
            let session = URLSession.shared
            let googurl = URL(string: serveurl)!
            dataTask = defaultSession.dataTask(with: googurl) {
                data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let responseData = data {
                            if let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? NSDictionary {
                                print(json)
                                self.jsonResult.append(json)
                            }
                        }
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    func themcalls(address:CLLocationCoordinate2D, ti:Float, de:String) -> ([CurrentRoutes]) {
        var custlat = address.latitude
        var custlon = address.longitude
        
        var rets = [CurrentRoutes]()
        
        var cnt:Int = 0;
        for jso in jsonResult {
            var rs = jso["rows"] as! NSArray
            var ro = rs[0] as! NSDictionary
            var elems = ro["elements"] as! NSArray
            var elem = elems[0] as! NSDictionary
            var distance = elem["distance"] as! NSDictionary
            var dist = distance["text"] as! String
            var duration = elem["duration"] as! NSDictionary
            var dur = duration["text"] as! String
            if(de == "AEDR"){
                if(drivers[cnt].latd < 33.66 && drivers[cnt].lond >  -112.00 && ti >= drivers[cnt].reachingtime) {
                    drivers[cnt].distanceofcarpool = dist
                    drivers[cnt].durationofcarpool = dur
                    rets.append(drivers[cnt])
                }
            }
            else {
                if(drivers[cnt].latd >= 33.66 && drivers[cnt].lond <=  -112.00 && ti >= drivers[cnt].reachingtime){
                    drivers[cnt].distanceofcarpool = dist
                    drivers[cnt].durationofcarpool = dur
                    rets.append(drivers[cnt])
                }
            }
            
            cnt += 1
        }
        
        print(rets.count)
        
        return rets
    }
}
