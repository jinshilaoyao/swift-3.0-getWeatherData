//
//  Weather.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class Weather: NSObject {
    private(set) var weatherId: Int = 0
    private(set) var main: String = ""
    private(set) var icon: String = ""
    private(set) var descriptionInfo: String = ""
    
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
        if key == "id" {
            weatherId = value as! Int
        }
        
        if key == "description" {
            descriptionInfo = value as! String
        }
    }
}
