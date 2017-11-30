//
//  ActualLocationPresenter.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation
import Moya

protocol ActualLocationPresenterDelegate: class {
    func updateActualLocationView(presenter: ActualLocationPresenter, updateViewModelWith viewModel:ActualLocationPresenter.ViewModel?)
}

class ActualLocationPresenter {
    weak var delegate: ActualLocationPresenterDelegate?
    var viewModel: ActualLocationPresenter.ViewModel!
    var provider = MoyaProvider<WeatherService>()
    var lat: String!
    var long: String!
    
    func sendData(actualLat:String, actualLong:String){
        lat = actualLat
        long = actualLong
        loadData()
    }
    
    func loadData(){
        let request = WeatherService.location(lat, long)
        let weatherService = WeatherService.location(lat, long)
        
        provider.request(request, completion: weatherService.response(completion: { (result) in
            switch result {
            case .success(let weathers):
                guard let weather = weathers as? APIResults else {
                    return
                }
                self.viewModel = ActualLocationPresenter.ViewModel(weathers: weather)
                self.delegate?.updateActualLocationView(presenter: self, updateViewModelWith: self.viewModel)
                break
            case .failure(_):
                break
            }
        }))
    }
}

extension ActualLocationPresenter {
    struct ViewModel {
        var weathers: APIResults
    }
}
