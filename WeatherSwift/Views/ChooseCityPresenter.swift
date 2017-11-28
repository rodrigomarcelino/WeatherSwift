//
//  ChooseCityPresenter.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation
import Moya

protocol ChooseCityPresenterDelegate: class {
    func updateView(presenter: ChooseCityPresenter, updateViewModelWith viewModel:ChooseCityPresenter.ViewModel?)
}

class ChooseCityPresenter {
    weak var delegate: ChooseCityPresenterDelegate?
    var viewModel: ChooseCityPresenter.ViewModel!
    var provider = MoyaProvider<WeatherService>()
    
    func loadData() {
        let teste = WeatherService.weather()
        let weatherService = WeatherService.weather()
        
        provider.request(teste, completion: weatherService.response(completion: { (result) in
            switch result {
            case .success(let weathers):
                guard let weather = weathers as? APIResults else {
                    return
                }
                self.viewModel = ChooseCityPresenter.ViewModel(weathers: weather)
                self.delegate?.updateView(presenter: self, updateViewModelWith: self.viewModel)
                break
            case .failure(_):
                break
            }
        }))
    }
}

extension ChooseCityPresenter {
    struct ViewModel {
        var weathers: APIResults
    }
}
