//
//  CurrentWeatherData.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class CurrentWeatherData: NSObject {
    
    private(set) var cod: Int = 0
    private(set) var name: String = ""
    private(set) var cityId: Int = 0
    private(set) var base: String = ""
    private(set) var dt: Int = 0
    private(set) var weathers: Array = Array<Weather>()
    private(set) var coord: Coord?
    private(set) var sys: Sys?
    private(set) var wind: Wind?
    private(set) var clouds: Clouds?
    private(set) var main: MainInfo?
    
    init(dict: Dictionary<String, Any>?) {
        super.init()
        guard let dict = dict else {
            return
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if value is NSNull {
            return
        }
        
        guard let value = value else {
            return
        }
        
        if key == "coord" {
            coord = Coord(dict: value as? Dictionary<String, Any>)
        }
        
        if key == "sys" {
            sys = Sys(dict: value as? Dictionary<String, Any>)
        }
        
        if key == "wind" {
            wind = Wind(dict: value as? Dictionary<String, Any>)
        }
        
        if key == "main" {
            main = MainInfo(dict: value as? Dictionary<String, Any>)
        }
        
        if (key == "weather") {
            guard let temp = value as? Array<Any> else {
                return
            }
            for dict in temp {
                let weather = Weather(dict: dict as? Dictionary<String, Any>)
                weathers.append(weather)
            }
            
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id" {
            cityId = value as! Int
        }
    }
    
    override var description: String {
        get {
            return "cod: \(cod),\ncityId: \(cityId),\nname: \(name),\nbase: \(base),\ndt: \(dt),\nweather: \(weathers),\nccoord: \(coord!.lat),\(coord!.lon),\nsys: \(sys!.description)\n"
        }
    }
    
}
