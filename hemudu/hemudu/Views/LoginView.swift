//
//  LoginView.swift
//  hemudu
//
//  Created by Ran Cao on 2017/2/26.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var projectiveUsername:String? = nil
var projectiveAge:Int = 1
var projectiveSex:String? = nil
var projectiveID:Int? = nil
var projectiveLevel:String? = nil
var projectiveMoney:String? = nil

class LoginView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var LgoinFaild: UILabel!
    @IBOutlet weak var SavePass: UISwitch!
    @IBAction func LoginBtn(_ sender: Any) {
        let Username:String = username.text!
        let Password:String = password.text!
        let url = "https://hepnovel.com/hemudu/ios/login.php"
        let para = ["username":Username, "password":Password]
        var LoginSuc:Bool = false
        
        request(url, method: .post, parameters: para).responseJSON { (response) in
            let data = response.result.value
            let json = JSON(data)
            print(json)
            let name = json["username"]
            let pass = json["password"]
            let age = json["age"]
            let sex = json["sex"]
            let ID = json["id"]
            let level = json["level"]
            let money = json["money"]
            if name == nil && pass == nil {
                LoginSuc = false
                print(LoginSuc)
                self.LgoinFaild.text = "登录失败"
                let LoginFaild = UIAlertController(title: "登录失败", message: "密码或用户名错误", preferredStyle: UIAlertControllerStyle.alert)
                let LoginFaildCancel = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: nil)
                LoginFaild.addAction(LoginFaildCancel)
                self.present(LoginFaild, animated: true, completion: nil)
            }else {
                LoginSuc = true
                print(LoginSuc)
                projectiveUsername = String(describing: name)
                projectiveAge = Int(String(describing: age))!
                projectiveSex = String(describing: sex)
                projectiveID = Int(String(describing: ID))
                projectiveLevel = String(describing: level)
                projectiveMoney = String(describing: money)
                if projectiveLevel == "NM" {
                    projectiveLevel = "普通会员"
                }else if projectiveLevel == "NV" {
                    projectiveLevel = "VIP会员"
                }else if projectiveLevel == "SV" {
                    projectiveLevel = "至尊VIP"
                }
                self.performSegue(withIdentifier: "login", sender: self)
                if self.SavePass.isOn == true {
                    UserDefaults.standard.set(self.username.text, forKey: "n")
                    UserDefaults.standard.set(self.password.text, forKey: "p")
                    
                }
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SavePass.isOn = true
        username.text = UserDefaults.standard.value(forKey: "n") as! String?
        password.text = UserDefaults.standard.value(forKey: "p") as! String?
        password.delegate=self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
