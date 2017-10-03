//
//  ViewController.swift
//  FuelEconomy
//
//  Created by Kana Miyasaka on 2017/09/08.
//  Copyright © 2017年 kanahebi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myUserDafault:UserDefaults = UserDefaults()
        print(myUserDafault.string(forKey: "AccessToken"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
