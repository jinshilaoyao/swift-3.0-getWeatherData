//
//  GetWeatherData.swift
//  weather_swift
//
//  Created by yesway on 2017/1/2.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit
import MapKit

protocol GetWeatherDataDelegate: NSObjectProtocol {
    func weatherData(object: Dictionary<String, Any>?, isSuccess: Bool)
}

let appidKey = "8c0e04b52e6da9e67c51a102d6269a60"

class GetWeatherData: NSObject {
    
     enum EGetWeatherDataValue: NSInteger {
        case kWeather = 1
        case kDaily = 2
    }

    weak var dataDelegate: GetWeatherDataDelegate?
    
    var location: CLLocation?
    
    var cityId: String = ""
    
    fileprivate(set)var currentConditions: CurrentConditions?
    fileprivate(set) var currentWeatherData: CurrentWeatherData?
    
    lazy private var networkWeather: NetWorking = {
        let networkWeather = NetWorking()
            networkWeather.tag = EGetWeatherDataValue.kWeather.rawValue
            networkWeather.timeoutInterval = 8.0
            networkWeather.method = PostMethod()
            networkWeather.requestBodyType = HttpBodyType()
            networkWeather.responseDataType = JsonDataType()
        return networkWeather
    }()
    lazy fileprivate var networkDaily: NetWorking = {
        let networkDaily = NetWorking()
        networkDaily.tag = EGetWeatherDataValue.kDaily.rawValue
        networkDaily.timeoutInterval = 8.0
        networkDaily.method = PostMethod()
        networkDaily.requestBodyType = HttpBodyType()
        networkDaily.responseDataType = JsonDataType()
        return networkDaily
    }()
    
    func startGetLocationWeatherData() {
        
        if location == nil {
            return
        }
        
        let baseUrl = "http://api.openweathermap.org/data/2.5/weather"
        let latStr = "\(location?.coordinate.latitude ?? 0.0)"
        let lonStr = "\(location?.coordinate.longitude ?? 0.0)"
        let urlString = baseUrl.appending("?lat=\(latStr)&lon=\(lonStr)&APPID=\(appidKey)")
        
        networkWeather.delegate = self
        networkWeather.urlString = urlString
        networkWeather.startRequest()
        
    }
}
extension GetWeatherData: AbsNetworkingDelegate {
    
    func requestSucess(_ networking: AbsNetworking!, data: Any!) {
        guard let dict = data as? Dictionary<String, Any> else {
            dataDelegate?.weatherData(object: nil, isSuccess: false)
            return
        }
        if networking.tag ==  EGetWeatherDataValue.kWeather.rawValue{

            let weatherdata = CurrentWeatherData(dict: dict)

            if weatherdata.cod == 200 {
                currentWeatherData = weatherdata
                let baseUrl = "http://api.openweathermap.org/data/2.5/forecast/daily"
                let urlString = baseUrl + "?id=\(currentWeatherData!.cityId)&cnt=14&APPID=\(appidKey)"
                
                networkDaily.urlString = urlString
                networkDaily.delegate = self
                networkDaily.startRequest()
            }
        } else if networking.tag ==  EGetWeatherDataValue.kDaily.rawValue {
            let currentData = CurrentConditions(dict: dict)
            if currentData.cod == 200 {
                currentConditions = currentData
                let wDict = ["WeatherData": currentWeatherData ?? nil,
                             "WeatherConditions": currentConditions ?? nil
                             ]
                dataDelegate?.weatherData(object: wDict, isSuccess: true)
            }
        } else {
            dataDelegate?.weatherData(object: nil, isSuccess: false)
        }
    }
    
    func requestFailed(_ networking: AbsNetworking!, error: Error!) {
        dataDelegate?.weatherData(object: nil, isSuccess: false)
    }
    
}
