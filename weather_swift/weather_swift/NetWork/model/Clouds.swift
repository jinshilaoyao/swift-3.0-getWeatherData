//
//  Clouds.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class Clouds: NSObject {
    private(set) var all: Double = 0.0
    
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
