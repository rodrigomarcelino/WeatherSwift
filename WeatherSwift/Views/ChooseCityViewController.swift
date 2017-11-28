//
//  ChooseCityViewController.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import UIKit

class ChooseCityViewController: UIViewController{

    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    private var presenter: ChooseCityPresenter = ChooseCityPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ChooseCityViewController: ChooseCityPresenterDelegate {
    func updateView(presenter: ChooseCityPresenter, updateViewModelWith viewModel: ChooseCityPresenter.ViewModel?) {
        cityLabel.text = viewModel?.weathers.name
        tempLabel.text = String(format:"%.2f",(viewModel?.weathers.main.temp)!)
        humidityLabel.text = String(format:"%.2f",(viewModel?.weathers.main.humidity)!)
        maxTempLabel.text = String(format:"%.2f",(viewModel?.weathers.main.temp_max)!)
        minTempLabel.text = String(format:"%.2f",(viewModel?.weathers.main.temp_min)!)
    }
}

extension ChooseCityViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText :String? = searchBar.text
        presenter.sendData(searchText: searchText!)
    }
}
