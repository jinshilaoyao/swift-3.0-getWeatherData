//
//  City.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class City: NSObject {
    
    private(set) var coord: Coord?
    private(set) var cityId: Int = 0
    private(set) var country: String = ""
    private(set) var name: String = ""
    private(set) var population: Int = 0
    
    init(dict: Dictionary<String, Any>?) {
        super.init()
        guard let dict = dict else {
            return
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id" {
            cityId = value as! Int
        }
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
    }
    
}
