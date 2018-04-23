//
//  ViewController.swift
//  useCLLocalManager
//
//  Created by Peter on 2018/4/21.
//  Copyright © 2018年 Peter. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    var locationManager: CLLocationManager!
    var localButton: UIButton!
    var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setLabel()
        self.navigationItem.title = "Map"
    }
    
    func setButton(){
        localButton = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.width/2 - 150, y: 500, width: 300, height: 60))
        localButton.setTitle("Find My Local", for: .normal)
        localButton.backgroundColor = .black
        localButton.addTarget(self, action: #selector(self.findLocation), for: .touchDown)
        self.view.addSubview(localButton)
    }
    
    func setLabel(){
        locationLabel = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.width/2 - 150, y: 70, width: 300, height: 70))
        locationLabel.text = "Please Press Button"
        locationLabel.textColor = .black
        locationLabel.textAlignment = .center
        self.view.addSubview(locationLabel)
    }
    
    @objc func findLocation(){
        self.locationManager = CLLocationManager.init()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationLabel.text = "While updating user's location " + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(self.locationManager.location!) { (placemarks, error) in
            if(error != nil){
                self.locationLabel.text = error?.localizedDescription
                return
            }
            
            if(placemarks!.count > 0){
                let placemark = placemarks![0]
                self.setLocationInfo(placemark: placemark)
            }
            else{
                self.locationLabel.text = "No Placemarks"
            }
        }
        manager.stopUpdatingLocation()
    }
    
    
    func setLocationInfo(placemark: CLPlacemark?){
        let name = placemark?.name != nil ? placemark?.name : nil
        let country = placemark?.country != nil ? placemark?.country: nil
        self.locationLabel.text = name! + " " + country!
        
    }
    


}

