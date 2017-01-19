//
//  CurrentConditions.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class CurrentConditions: NSObject {
    private(set) var city: City?
    private(set) var list = Array<WeatherInfo>()
    private(set) var message: Double = 0.0
    private(set) var cod: Int = 0
    private(set) var cnt: Double = 0.0
    
    init(dict: Dictionary<String, Any>?) {
        super.init()
        guard let dict = dict else {
            return
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if value is NSNull {
            return
        }
        
        guard let value = value else {
            return
        }
        
        if key == "city" {
            city = City(dict: value as? Dictionary<String, Any>)
        }
        
        if (key == "list") {
            guard let temp = value as? Array<Any> else {
                return
            }
            for dict in temp {
                let weatherInfo = WeatherInfo(dict: dict as? Dictionary<String, Any>)
                list.append(weatherInfo)
            }
        }
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        
    }
    
}
