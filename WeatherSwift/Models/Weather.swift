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
    var cod: Int?
    var main: Mainn?
    var sys: Sys?
    var description: [Description]?
    private enum CodingKeys: String, CodingKey {
        case main = "main", name = "name", sys = "sys", cod = "cod", description = "weather"
    }
}

struct Mainn: Codable{
    var temp: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct Sys: Codable {
    var country: String?
}

struct Description: Codable{
    var icon: String?
}

