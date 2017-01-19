//
//  ViewController.swift
//  weather_swift
//
//  Created by yesway on 2017/1/2.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    fileprivate var mapLocation: MapManager? {
        didSet {
            mapLocation?.mapDelegate = self
        }
    }
    
    private var getWeatherData: GetWeatherData? {
        didSet {
            getWeatherData?.dataDelegate = self
        }
    }
    
    lazy var fadeBlackView: FadeBlackView = {
       let view = FadeBlackView()
        return view
    }()
    
    lazy var upDatingView: UpdatingView = {
        let view = UpdatingView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        perpareUI()
        
        mapLocation = MapManager()
        
        getWeatherData = GetWeatherData()

        getLocationAndFadeShow()
        
    }
    
    // MARK: - Tools
    
    func perpareUI() {
        view.addSubview(fadeBlackView)
        view.addSubview(upDatingView)
    }
    
    func delayRunEvent(location: CLLocation) {
        
        getWeatherData?.location = location
        
        getWeatherData?.startGetLocationWeatherData()
        
    }
    
    func getLocationAndFadeShow() {
        
        fadeBlackView.show()
        upDatingView.show()
        
        mapLocation?.start()
    }
    
    func showWeatherView() {
        fadeBlackView.hide()
        upDatingView.hide()
    }
}

extension ViewController: MapManagerLocationDelegate {
    
    func mapManagerServerClosed(manager: MapManager) {
        
    }
    
    func mapManager(manager: MapManager, didFailed error: Error) {
        print("定位失败")
    }
    
    func mapManager(manager: MapManager, didUpateAndGetLastCllocation location: CLLocation) {
        print(" 定位成功")
        
        self.perform(#selector(delayRunEvent(location:)), with: location)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(delayRunEvent(location:)), object: location)
        
    }

}
extension ViewController: GetWeatherDataDelegate {
    func weatherData(object: Dictionary<String, Any>?, isSuccess: Bool) {
        mapLocation?.stop()
        showWeatherView()
        if isSuccess {
            guard let data = object?["WeatherData"] as? CurrentWeatherData, let conditions = object?["WeatherConditions"] as? CurrentConditions else {
                return
            }
            
        } else {
            
        }
    }
}
