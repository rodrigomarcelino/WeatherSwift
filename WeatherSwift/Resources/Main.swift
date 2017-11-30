//
//  Main.swift
//  WeatherSwift
//
//  Created by Rodrigo on 29/11/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation
import UIKit

struct Main {
    
    var notFoundImage = "notFound"
    var cityNotFoundText = " Cidade não encontrada! "
    var locationNotFoundText1 = " Localização não encontrada "
    var locationNotFoundText2 = " Verifique suas configurações "
    static let sharedInstance = Main()
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
