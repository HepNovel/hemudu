//
//  MineView.swift
//  hemudu
//
//  Created by Ran Cao on 2017/3/19.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit

class MineView:UIViewController {
    
    
    @IBOutlet weak var Info: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Info.text = "用户名：\(projectiveUsername!)\n性别：\(projectiveSex!)\n年龄：\(projectiveAge)\n会员等级:\(projectiveLevel!)\n积分：\(projectiveMoney!)"
        Info.numberOfLines = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
