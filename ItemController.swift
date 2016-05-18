//
//  ItemController.swift
//  tips
//
//  Created by Le An Khang on 5/17/16.
//  Copyright © 2016 Le An Khang. All rights reserved.
//

import UIKit

class ItemController: UIViewController, UIPickerViewDelegate {

    @IBAction func doneClickEvent(sender: AnyObject) {
        var data = defaults.objectForKey("items") as! [String];
        print(items)
        data.append("24")
        defaults.setObject(data, forKey: "items");
        defaults.synchronize();
    }
    
    @IBOutlet weak var items: UIPickerView!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var pickerDataSource = [String]();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.items.dataSource = self;
        self.items.delegate = self;

        for i in 0..<51 {
            pickerDataSource.append((i*2).description);
        }
        
        for item in defaults.objectForKey("items") as! [String] {
            print(item)
            pickerDataSource.removeAtIndex(pickerDataSource.indexOf(item)!)
        }
        
        // Do any additional setup after loading the view.
        //pickerDataSource = defaults.objectForKey("items") as! [String];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickerDataSource[row])
        return pickerDataSource[row]
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
