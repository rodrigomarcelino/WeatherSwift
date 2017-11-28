//
//  ChooseCityViewController.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import UIKit

class ChooseCityViewController: UIViewController {
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var presenter: ChooseCityPresenter = ChooseCityPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.loadData()
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
        humidityLabel.text = String(format:"%.2f",(viewModel?.weathers.main.temp_max)!)
        timeLabel.text = String(format:"%.2f",(viewModel?.weathers.main.temp_min)!)
    }
}
