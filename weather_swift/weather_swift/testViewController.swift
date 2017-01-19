//
//  testViewController.swift
//  weather_swift
//
//  Created by yesway on 2017/1/18.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class People: NSObject {
    private(set) var name: String
    
    
    class func share() -> People{
        
        let p = People(name: "p")
        p.name = "share P"
        return p
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    func updata(name: String) {
        self.name = name
    }
}

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let p = People.share()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
