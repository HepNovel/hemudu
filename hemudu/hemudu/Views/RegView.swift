//
//  RegView.swift
//  hemudu
//
//  Created by Ran Cao on 2017/2/26.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegView: UIViewController {
    var uCanOrCannot:Bool = true
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var fenbu: UISegmentedControl!
    @IBOutlet weak var Cannot: UILabel!
    
    @IBAction func CheckUsername(_ sender: Any) {
        let username:String = self.username.text!
        let url = "https://hepnovel.com/hemudu/ios/check.php"
        let para = ["username":username]
        request(url, method: .post, parameters: para).responseJSON{
            (response) in
            let data = response.result.value
            let json = JSON(data)
            let check = json["username"]
            if check != nil {
                self.Cannot.textColor = UIColor.red
                self.Cannot.text = "用户名无法使用"
                self.uCanOrCannot = false
            }else{
                self.Cannot.textColor = UIColor(red: 70/255, green: 217/255, blue: 84/255, alpha: 1)
                self.Cannot.text = "用户名可以使用"
                self.uCanOrCannot = true
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
