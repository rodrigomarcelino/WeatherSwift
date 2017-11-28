//
//  WeatherService.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation
import Moya
import Result

enum WeatherService {
    case weather(String)
}

extension WeatherService: TargetType{
    //    var city: String!
    //    city = "city"
    var baseURL: URL {
        switch self {
        case .weather(let city):
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)")!
        }
    }
    
    var path: String {
            return ""
    }
    
    var method: Moya.Method {
        switch self {
        case .weather(_):
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
       case .weather(_):
            return [
                "units": "metric",
                "APPID": "4899f0f33f91ac6422946c7aaf7598d6"
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var sampleData: Data {
            return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    func response(completion: @escaping (_ responseResult: Result<Codable?, ServiceError>) -> Void) -> Completion {
        switch self {
        case .weather(_):
            return { (result) in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    if moyaResponse.response?.expectedContentLength == 0 {
                        completion(.success(nil))
                        return
                    }
                    do {
                        let responseObject = try JSONDecoder().decode(APIResults.self, from: data)
                        completion(.success(responseObject))
                        
                    } catch {
                        let mappingError = MoyaError.jsonMapping(moyaResponse)
                        completion(.failure(ServiceError.moyaError(mappingError)))
                    }
                case let .failure(error):
                    completion(.failure(ServiceError.moyaError(error)))
                    break
                }
                
            }
        }
        
    }
}


