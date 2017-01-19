//
//  Sys.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class Sys: NSObject {
    private(set) var message: Double = 0
    private(set) var country: String = ""
    private(set) var sunset: Int = 0
    private(set) var sunrise: Int = 0
    
    init(dict: Dictionary<String, Any>?) {
        super.init()
        guard let dict = dict else {
            return
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        get {
            return "\n{message: \(message),\ncountry: \(country),\nsunset: \(sunset),\nsunrise: \(sunrise),\n}"
        }
    }
}
