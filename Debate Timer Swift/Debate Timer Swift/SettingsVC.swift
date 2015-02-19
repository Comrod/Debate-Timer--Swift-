//
//  SettingsVC.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/10/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    //Variables
    var segueSettingsToTimer = "segueSettingsToTimer"
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    //IB Outlets
    @IBOutlet weak var centisecondSegControl: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Decimals
        if (Global.isCenti)
        {
            //Centiseconds is highlighted
            centisecondSegControl.selectedSegmentIndex = 0
        }
        else
        {
            //Centiseconds is not highlighted
            centisecondSegControl.selectedSegmentIndex = 1
        }
        
        
    }
    
    
    @IBAction func centisecondValueChanged(sender: AnyObject)
    {
        if (centisecondSegControl.selectedSegmentIndex == 0)
        {
            Global.isCenti = true
            defaults.setBool(true, forKey: "isCenti")
        }
        else if (centisecondSegControl.selectedSegmentIndex == 1)
        {
            Global.isCenti = false
            defaults.setBool(false, forKey: "isCenti")
        }
    }
    
    @IBAction func backButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueSettingsToTimer, sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
