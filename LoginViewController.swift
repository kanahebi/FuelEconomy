//
//  LoginViewController.swift
//  FuelEconomy
//
//  Created by Kana Miyasaka on 2017/09/14.
//  Copyright © 2017年 kanahebi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButton(_ sender: UIButton) {
        let url = URL(string: "http://localhost:3000/api/auth/sign_in")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let email    = emailTextField.text!
        let password = passwordTextField.text!
        let params: [String: Any?] = [
            "email": email,
            "password": password
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
            let task: URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
//                let resultData = String(data: data!, encoding: .utf8)!
                let res = response as! HTTPURLResponse
                let header = res.allHeaderFields as NSDictionary
                let myUserDefault:UserDefaults = UserDefaults()
                let accessToken = header["access-token"] as! String
                let client = header["client"] as! String
                let uid = header["uid"] as! String
                print(accessToken)
                print(client)
                print(uid)
                myUserDefault.set(accessToken, forKey: "AccessToken")
                myUserDefault.set(client, forKey: "client")
                myUserDefault.set(uid, forKey: "uid")
//                print("¥n¥nresult:\(resultData)")
//                print("¥n¥nresponse:\(response)")
                
            })
            task.resume()
        }catch{
            print("Error:\(error)")
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
