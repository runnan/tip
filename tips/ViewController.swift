//
//  ViewController.swift
//  tips
//
//  Created by Le An Khang on 5/15/16.
//  Copyright © 2016 Le An Khang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var resultView: UIView!

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let formatter = NSNumberFormatter()
    var defaults = NSUserDefaults.standardUserDefaults()
    var tipDefaultPercentages = ["18","20","22"];
    var isCustom = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        calculate();
    }
    
    func calculate() {
        handleAnimation();
        
        var tipPercentages = tipDefaultPercentages;
        //if(defaults.objectForKey("items") != nil){
        //   tipPercentages = defaults.objectForKey("items") as! [String];
        //}
        print(tipControl.selectedSegmentIndex)
        let tipPercentage = NSString(string : tipPercentages[tipControl.selectedSegmentIndex]).doubleValue/100;
        
        let billAmount = NSString(string : billField.text!).doubleValue;
        let tip = billAmount * tipPercentage;
        let total = billAmount + tip;
        
        tipLabel.text = String(format:  "%.2f \(formatter.currencySymbol)",tip);
        totalLabel.text = String(format: "%.2f \(formatter.currencySymbol)",total);
        
        
    }
    
    func handleAnimation(){
        if(billField.text == ""){
            UIView.animateWithDuration(0.4, animations: {
                self.resultView.alpha = 0
            })
        }else{
            UIView.animateWithDuration(0.4, animations: {
                self.resultView.alpha = 1
            })
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        
        self.infoView.alpha = 1
        self.resultView.alpha = 0
        self.billField.placeholder = formatter.currencySymbol;
        
        
        //init combobox value
        isCustom = defaults.boolForKey("isCustom");
        tipControl.removeAllSegments()
        if(!isCustom){
            tipDefaultPercentages = ["18","20","22"];
            for item in tipDefaultPercentages {
                tipControl.insertSegmentWithTitle("\(item)%", atIndex: tipDefaultPercentages.indexOf(item)!, animated: false)
            }
        }else{
            tipDefaultPercentages = defaults.objectForKey("customItems") as! [String]
            for item in  tipDefaultPercentages{
                tipControl.insertSegmentWithTitle("\(item)%", atIndex: tipDefaultPercentages.indexOf(item)!, animated: false)
            }
        }
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip");
        calculate();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        self.navigationItem.title = "Tip Calculator"
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
}

