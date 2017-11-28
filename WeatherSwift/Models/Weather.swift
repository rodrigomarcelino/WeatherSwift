//
//  Weather.swift
//  WeatherSwift
//
//  Created by Rodrigo on 28/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation
import UIKit

struct APIResults: Codable {
    var name: String?
    var main: Main
    var sys: Sys
    private enum CodingKeys: String, CodingKey {
        case main = "main", name = "name", sys = "sys"
    }
}

struct Main: Codable{
    var temp: Double?
    //var tempString =  .decode(String(format:"%.2f",()!))
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct Sys: Codable {
    var country: String?
}
