//
//  LoginView.swift
//  hemudu
//
//  Created by Ran Cao on 2017/2/26.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit

var projectiveUsername:String? = nil
var projectiveAge:Int = 1
var projectiveSex:String? = nil
var projectiveID:Int? = nil
var projectiveLevel:String? = nil

class LoginView: UIViewController, UITextViewDelegate {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginDo(_ sender: Any) {
        let Username = username.text
        let Password = password.text
        
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
