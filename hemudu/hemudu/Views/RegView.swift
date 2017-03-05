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
    var sexString = "保密"
    var fenbuString = "unknow"
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
    @IBAction func Reg(_ sender: Any) {
        let username:String = self.username.text!
        let password:String = self.password.text!
        let repass:String = self.repassword.text!
        let sex = self.sex.selectedSegmentIndex
        if sex == 0 {
            sexString = "男"
        }else{
            sexString = "女"
            
        }
        let age:String = self.age.text!
        let fenbu = self.fenbu.selectedSegmentIndex
        if fenbu == 0 {
            fenbuString = "北京市师大附中"
        }else if fenbu == 1 {
            fenbuString = "北京市铁二中"
        }else if fenbu == 2 {
            fenbuString = "北京市第一六一中学"
        }else if fenbu == 3 {
            fenbuString = "北京市第四十三中学"
        }else if fenbu == 4 {
            fenbuString = "西城区外国语学校"
        }
        if username != "" && password != "" && repass != "" && age != "" {
            if uCanOrCannot == false{
                let uCheckNotPassAlert = UIAlertController(title: "用户名已存在", message: "请换一个试试", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "好的", style: .default, handler: nil)
                uCheckNotPassAlert.addAction(action1)
                self.present(uCheckNotPassAlert, animated: true, completion: nil)
            }else{
                if password == repass {
                    let url = "https://hepnovel.com/hemudu/ios/reg.php"
                    let para = ["username":username, "password":password, "sex":sexString, "age":age, "fenbu":fenbuString]
                    request(url, method: .post, parameters: para).responseJSON{
                        (response) in
                        let data = response.result.value
                        let json = JSON(data)
                        let didDoneU = json["username"]
                        let didDoneBool = json["suc"]
                        if String(describing: didDoneU) == username && didDoneBool == "true" {
                            let suc = UIAlertController(title: "注册成功",
                                                        message: "即将返回登录",
                                                        preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "确定", style: .default,handler: {action in
                                self.performSegue(withIdentifier: "cReg", sender: self)
                            }
                            )
                            suc.addAction(okAction)
                            self.present(suc, animated: true, completion: nil)
                        }else{
                            print("服务端错误！")
                        }
                    }
                }else{
                    let passError = UIAlertController(title: "错误！",
                                                      message: "两次输入密码不同",
                                                      preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "确定", style: .default,handler:nil)
                    passError.addAction(okAction)
                    self.present(passError, animated: true, completion: nil)
                }
            }
        }else{
            let notAllAlert = UIAlertController(title: "请填写完整",
                                                message: "返回填写",
                                                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default,handler:nil)
            notAllAlert.addAction(okAction)
            self.present(notAllAlert, animated: true, completion: nil)
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
