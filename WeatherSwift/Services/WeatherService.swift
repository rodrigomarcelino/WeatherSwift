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
    case weather()
}

extension WeatherService: TargetType{
    //    var city: String!
    //    city = "city"
    var baseURL: URL {
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&units=metric&APPID=4899f0f33f91ac6422946c7aaf7598d6")!
    }
    
    var path: String {
        switch self {
        case .weather():
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weather():
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .weather():
            return Data()
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    func response(completion: @escaping (_ responseResult: Result<Codable?, ServiceError>) -> Void) -> Completion {
        switch self {
        case .weather():
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


