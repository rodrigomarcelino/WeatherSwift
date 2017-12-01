//
//  ChooseCityViewController.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import UIKit
import SwiftOverlays

class ChooseCityViewController: UIViewController{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var minTempImage: UIImageView!
    @IBOutlet weak var maxTempImage: UIImageView!
    @IBOutlet weak var humidityImage: UIImageView!
    @IBOutlet weak var tempImage: UIImageView!
    
    private var presenter: ChooseCityPresenter = ChooseCityPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	@IBOutlet var tapDismissKeyboard: UITapGestureRecognizer!
	@IBAction func tapDismissKeyboard(_ sender: Any) {
		searchBar.resignFirstResponder()
	}
}


extension ChooseCityViewController: ChooseCityPresenterDelegate {
    func updateView(presenter: ChooseCityPresenter, updateViewModelWith viewModel: ChooseCityPresenter.ViewModel?) {
        
        if let cod = viewModel?.weathers.cod{
            if cod == 0{
                
                self.iconImage.image = UIImage(named: Main.sharedInstance.notFoundImage)
                self.cityLabel.text = Main.sharedInstance.cityNotFoundText
                self.tempLabel.text = ""
                self.background.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "66CCFF")
                
            }else{
                
                if let temp :String = String(format:"%.0f",(viewModel?.weathers.main?.temp)!), let city = viewModel?.weathers.name,
                    let country = viewModel?.weathers.sys?.country , let icon = viewModel?.weathers.description![0].icon,
                    let humidity:String = String(format:"%.0f",(viewModel?.weathers.main?.humidity)!),
                    let minTemp:String = String(format:"%.0f",(viewModel?.weathers.main?.temp_min)!),
                    let maxTemp:String = String(format:"%.0f",(viewModel?.weathers.main?.temp_max)!){
                    
                    self.cityLabel.text = " " + city + " - " + country + " "
                    self.tempLabel.text = temp
                    self.humidityLabel.text = humidity + "%"
                    self.maxTempLabel.text = maxTemp + "˚C"
                    self.minTempLabel.text = minTemp + "˚C"
                    
                    self.iconImage.image = UIImage(named: icon)
                    self.minTempImage.image = UIImage(named: "minTemp")
                    self.maxTempImage.image = UIImage(named: "maxTemp")
                    self.humidityImage.image = UIImage(named: "humidity")
                    self.tempImage.image = UIImage(named: "celsius")
                    
                    if icon.contains("d"){
                        self.background.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "66CCFF")
                    }else{
                        self.background.backgroundColor = Main.sharedInstance.hexStringToUIColor(hex: "2E596C")
                    }
                }
                
            }
        }
        self.removeAllOverlays()
    }
	
	func updateErrView(presenter: ChooseCityPresenter, updateViewModelWith viewModel:ChooseCityPresenter.ViewModel?) {
		self.cityLabel.text = " "
		self.tempLabel.text = ""
		self.humidityLabel.text = ""
		self.maxTempLabel.text = ""
		self.minTempLabel.text = ""
		
		let alert = UIAlertController(title: "", message: "Não encontramos resultados para essa cidade", preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}

extension ChooseCityViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.showWaitOverlay()
        var searchText :String? = searchBar.text
        searchBar.resignFirstResponder()
        searchText = searchText?.replacingOccurrences(of: " ", with: "+")
		searchText = searchText?.folding(options: .diacriticInsensitive, locale: .current)
        searchText = searchText?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        if let searchText = searchText{
        presenter.sendData(searchText: searchText)
        }
    }
}
