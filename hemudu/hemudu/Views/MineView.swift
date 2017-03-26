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
    
    
    let kSectionCount:Int = 2
    let kRedSection: Int = 0
    let kBlueSection: Int = 1
    
    let redFlowers: [String] = ["Gerbera","Peony","Rose","Poppy"]
    let blueFlowers: [String] = ["Hyacinth","Hydrangea","Sea Holly","Phlox","Iris"]
    
    
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "flowerCell")! as UITableViewCell
        switch ((indexPath as NSIndexPath).section) {
        case kRedSection:
            cell.textLabel!.text=redFlowers[(indexPath as NSIndexPath).row]
        case kBlueSection:
            cell.textLabel!.text=blueFlowers[(indexPath as NSIndexPath).row]
        default:
            cell.textLabel!.text="Unknown"
        }
        
        let flowerImage: UIImage=UIImage(named: cell.textLabel!.text!)!
        cell.imageView!.image=flowerImage
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case kRedSection:
            return "Red"
        case kBlueSection:
            return "Blue"
        default:
            return "Unknown"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kRedSection:
            return redFlowers.count
        case kBlueSection:
            return blueFlowers.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var flowerMessage: String
        switch (indexPath as NSIndexPath).section {
        case kRedSection:
            flowerMessage = "选择了红花 - \(redFlowers[(indexPath as NSIndexPath).row])"
        case kBlueSection:
            flowerMessage = "选择了绿花 - \(blueFlowers[(indexPath as NSIndexPath).row])"
        default:
            flowerMessage = "我不知道选择什么!"
        }
        
        let alertController = UIAlertController(title: "选择的是",
                                                message: flowerMessage,
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "好",
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil)
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
