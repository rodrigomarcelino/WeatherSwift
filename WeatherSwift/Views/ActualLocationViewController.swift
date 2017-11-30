//
//  ActualLocationViewController.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import UIKit
import CoreLocation

class ActualLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet var background: UIView!
    
    private var presenter: ActualLocationPresenter = ActualLocationPresenter()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
    }
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat :String = String(format:"%f",(location.coordinate.latitude))
            let long :String = String(format:"%f",(location.coordinate.longitude))
            presenter.sendData(actualLat: lat, actualLong: long)
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension ActualLocationViewController: ActualLocationPresenterDelegate {
    func updateActualLocationView(presenter: ActualLocationPresenter, updateViewModelWith viewModel: ActualLocationPresenter.ViewModel?) {
        
        if let cod = viewModel?.weathers.cod{
            if cod == 0{
                
                self.iconImage.image = UIImage(named: Main.sharedInstance.notFoundImage)
                self.cityLabel.text = Main.sharedInstance.cityNotFoundText
                self.tempLabel.text = ""
                self.background.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "66CCFF")
                
            }else{
                
                if let temp :String = String(format:"%.2f",(viewModel?.weathers.main?.temp)!), let city = viewModel?.weathers.name,
                    let country = viewModel?.weathers.sys?.country , let icon = viewModel?.weathers.description![0].icon,
                    let humidity:String = String(format:"%.2f",(viewModel?.weathers.main?.humidity)!),
                    let minTemp:String = String(format:"%.2f",(viewModel?.weathers.main?.temp_min)!),
                    let maxTemp:String = String(format:"%.2f",(viewModel?.weathers.main?.temp_max)!){
                    
                    self.cityLabel.text = " " + city + " - " + country + " "
                    self.tempLabel.text = "Temperatura :" + temp + "˚C"
                    self.humidityLabel.text = "Humidade :" + humidity + "%"
                    self.maxTempLabel.text = "Máxima :" + maxTemp + "˚C"
                    self.minTempLabel.text = "Mínima :" + minTemp + "˚C"
                    
                    self.iconImage.image = UIImage(named: icon)
                    
                    if icon.contains("d"){
                        self.background.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "66CCFF")
                    }else{
                        self.background.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "2E596C")
                    }
                }
            }
        }
    }
}
