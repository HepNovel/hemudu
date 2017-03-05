//
//  FirstViewController.swift
//  hemudu
//
//  Created by Ran Cao on 2017/2/26.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit
import StoreKit

class FirstViewController: UIViewController {
    
    let VERIFY_RECEIPT_URL = "https://buy.itunes.apple.com/verifyReceipt"
    let ITMS_SANDBOX_VERIFY_RECEIPT_URL = "https://sandbox.itunes.apple.com/verifyReceipt"
    
    var productDict:NSMutableDictionary!
    
    
    @IBOutlet weak var Info: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Info.text = "用户名：\(projectiveUsername!)\n性别：\(projectiveSex!)\n年龄：\(projectiveAge)\n会员等级:\(projectiveLevel!)\n积分：\(projectiveMoney!)"
        Info.numberOfLines = 0
        
        //SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        //requestProducts()
        
    }
    
    //deinit{
    //    SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

