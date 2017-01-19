//
//  MainInfo.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class MainInfo: NSObject {
    private(set) var humidity: Double = 0
    private(set) var temp_min: Double = 0
    private(set) var temp_max: Double = 0
    private(set) var temp: Double = 0
    private(set) var pressure: Double = 0
    private(set) var sea_level: Double = 0
    private(set) var grnd_level: Double = 0
    
    init(dict: Dictionary<String, Any>?) {
        super.init()
        guard let dict = dict else {
            return
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
