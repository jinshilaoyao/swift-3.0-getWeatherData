//
//  FadeBlackView.swift
//  weather_swift
//
//  Created by yesway on 2017/1/19.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class FadeBlackView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: Content.ScreenBound.Width, height: Content.ScreenBound.Height))
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alpha = 0.0
    }
    
    func show() {
        UIView.animate(withDuration: 1) { 
            self.alpha = 0.75
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.75) { 
            self.alpha = 0.0
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
