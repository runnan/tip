//
//  SettingsViewController.swift
//  tips
//
//  Created by Le An Khang on 5/17/16.
//  Copyright © 2016 Le An Khang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var num3: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var num1: UITextField!
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    let tipDefaultPercentages = ["18","20","22"];
    var defaults = NSUserDefaults.standardUserDefaults()
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customView.alpha = 0
        // Do any additional setup after loading the view.
        stateSwitch.setOn(defaults.boolForKey("isCustom"), animated: false );
        if(stateSwitch.on){
            self.customView.alpha = 1
            var data = defaults.objectForKey("customItems") as! [String];
            num1.text = data[0]
            num2.text = data[1]
            num3.text = data[2]
            reloadSegment()
        }
         defaultTipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onEditChange(sender: AnyObject) {
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTip");
        defaults.synchronize();
    }
    
    
    @IBAction func swichChange(sender: UISwitch) {
        defaults.setBool(stateSwitch.on, forKey: "isCustom");
        defaults.synchronize();
        
        if(stateSwitch.on){
            self.customView.alpha = 1
        }else{
            self.customView.alpha = 0
        }
        num1.text = tipDefaultPercentages[0]
        num2.text = tipDefaultPercentages[1]
        num3.text = tipDefaultPercentages[2]
        reloadSegment()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTip");
    }
    
    
    
    func reloadSegment(){
        let num1Txt = NSString(string : num1.text!).doubleValue
        let num2Txt = NSString(string : num2.text!).doubleValue
        let num3Txt = NSString(string : num3.text!).doubleValue

        
        defaultTipControl.removeAllSegments()
        defaultTipControl.insertSegmentWithTitle("\(String(format: "%.0f",num1Txt))%", atIndex: 0, animated: false)
        defaultTipControl.insertSegmentWithTitle("\(String(format: "%.0f",num2Txt))%", atIndex: 1, animated: false)
        defaultTipControl.insertSegmentWithTitle("\(String(format: "%.0f",num3Txt))%", atIndex: 2, animated: false)
        defaultTipControl.selectedSegmentIndex = 0;
        
        
        var segments = [String]()
        segments.insert(String(format: "%.0f",num1Txt), atIndex: 0)
        segments.insert(String(format: "%.0f",num2Txt), atIndex: 1)
        segments.insert(String(format: "%.0f",num3Txt), atIndex: 2)
        defaults.setObject(segments, forKey: "customItems");
        
        defaults.synchronize();
    }
    
    
    @IBAction func num1Changed(sender: AnyObject) {
        reloadSegment()
    }
    @IBAction func num1Change(sender: UITextField) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
