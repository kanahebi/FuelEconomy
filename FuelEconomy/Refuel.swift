//
//  Refuel.swift
//  FuelEconomy
//
//  Created by Kana Miyasaka on 2017/09/11.
//  Copyright © 2017年 kanahebi. All rights reserved.
//

import Foundation

class Refuel {
    let id: Int
    var distance: Float
    var gasoline: Float
    var price: Int
    var fuelEconomy: Float
    var refuelDate: String
//    var createdAt
//    var updatedAt
//    let url: URL
    
    init(refuel: [String:AnyObject]) {
        let dateFormatter = DateFormatter()
        let convDateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ja_JP")
        convDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        convDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        convDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // ID
        self.id = refuel["id"] as! Int
        
        // Distance
        if refuel["distance"] is NSNull {
            self.distance = 0.0
        } else {
            self.distance = refuel["distance"] as! Float
        }
        
        // Gasoline
        if refuel["gasoline"] is NSNull {
            self.gasoline = 0.0
        } else {
            self.gasoline = refuel["gasoline"] as! Float
        }
        
        // Price
        if refuel["price"] is NSNull {
            self.price = 0
        } else {
            self.price = refuel["price"] as! Int
        }
        
        // FuelEconomy
        if refuel["fuel_economy"] is NSNull {
            self.fuelEconomy = 0
        } else {
            self.fuelEconomy = refuel["fuel_economy"] as! Float
        }
        
        // RefuelDate
        if refuel["refuel_date"] is NSNull {
            self.refuelDate = ""
        } else {
            let convDate = convDateFormatter.date(from: refuel["refuel_date"] as! String)
            if convDate == nil {
                self.refuelDate = ""
            } else {
                self.refuelDate = dateFormatter.string(from: convDate!)
            }
        }
    }
}
