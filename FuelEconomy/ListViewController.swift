//
//  ListViewController.swift
//  FuelEconomy
//
//  Created by Kana Miyasaka on 2017/09/08.
//  Copyright © 2017年 kanahebi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let tableView = UITableView()
    var refuels = [Refuel]()
    let myUserDefault:UserDefaults = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64
        
        setList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setList() {
        let url: URL = URL(string: "http://localhost:3000/refuels.json")!
        var request: URLRequest = URLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(myUserDefault.string(forKey: "AccessToken")!, forHTTPHeaderField: "access-token")
        request.addValue(myUserDefault.string(forKey: "client")!, forHTTPHeaderField: "client")
        request.addValue(myUserDefault.string(forKey: "uid")!, forHTTPHeaderField: "uid")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
            if data != nil {
                do {
                    let getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                    
                    for _value in getJson {
                        let value = _value as! NSDictionary
                        let refuel = Refuel(refuel: value as! [String : AnyObject])
                        self.refuels.append(refuel)
                        print(refuel.refuelDate)
                    }
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                } catch {
                    print("error")
                    print(error)
                }

            } else {
                DispatchQueue.main.async(execute: {
                    print("error")
                })
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let refuel = self.refuels[indexPath.row]
        
        cell.accessoryType = .none
        cell.textLabel?.text = "\(refuel.refuelDate) \(refuel.fuelEconomy) km/L"
        cell.detailTextLabel?.text = "\(refuel.distance)km \(refuel.gasoline)L \(refuel.price) 円"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.refuels.count
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
