//
//  ServiceError.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation
import Moya

public struct BusinessError: Codable, Error {
    var code: String?
    var text: String?
    var title: String?
}

public enum ServiceError: Swift.Error {
    case businessError(BusinessError)
    case moyaError(MoyaError)
}
