//
//  UserRegistViewController.swift
//  FuelEconomy
//
//  Created by Kana Miyasaka on 2017/09/14.
//  Copyright © 2017年 kanahebi. All rights reserved.
//

import UIKit

class UserRegistViewController: UIViewController {
    @IBOutlet weak var nameTextField:     UITextField!
    @IBOutlet weak var carModelTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func registButton(_ sender: UIButton) {
        let url = URL(string: "http://localhost:3000/api/auth")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let name     = nameTextField.text!
        let carModel = carModelTextField.text!
        let email    = emailTextField.text!
        let password = passwordTextField.text!
        let params: [String: Any?] = [
            "name": name,
            "car_model": carModel,
            "email": email,
            "password": password
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
            let task: URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
                let resultData = String(data: data!, encoding: .utf8)!
                print("result:\(resultData)")
                print("response:\(response)")
                
            })
            task.resume()
        }catch{
            print("Error:\(error)")
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.clearButtonMode     = .whileEditing
        carModelTextField.clearButtonMode = .whileEditing
        emailTextField.clearButtonMode    = .whileEditing
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true

        // Do any additional setup after loading the view.
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
