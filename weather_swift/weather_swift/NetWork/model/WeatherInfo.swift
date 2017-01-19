//
//  WeatherInfo.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class WeatherInfo: NSObject {
    
    private(set) var weathers = Array<Weather>()
    private(set) var temp: Temp?
    private(set) var clouds: Double = 0.0
    private(set) var humidity: Double = 0.0
    private(set) var dt: Double = 0.0
    private(set) var speed: Double = 0.0
    private(set) var pressure: Double = 0.0
    private(set) var deg: Double = 0.0
    
    
    init(dict: Dictionary<String, Any>?) {
        super.init()
        guard let dict = dict else {
            return
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if value is NSNull {
            return
        }
        
        guard let value = value else {
            return
        }
        
        if key == "temp" {
            temp = Temp(dict: value as? Dictionary<String, Any>)
        }
        
        if key == "weahter" {
            guard let temp = value as? Array<Any> else {
                return
            }
            for dict in temp {
                let weather = Weather(dict: dict as? Dictionary<String, Any>)
                weathers.append(weather)
            }
        }
    }
}
