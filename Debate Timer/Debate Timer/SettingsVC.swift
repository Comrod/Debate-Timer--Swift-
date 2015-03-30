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
    @IBOutlet weak var primaryStyleSegControl: UISegmentedControl!
    @IBOutlet weak var homeSkipSwitch: UISwitch!
    @IBOutlet weak var prepStepper: UIStepper!
    @IBOutlet weak var prepLabel: UILabel!
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
        
        //Set the value of primary style segment control and home skip
        primaryStyleSegControl.selectedSegmentIndex = Global.primaryStyle
        homeSkipSwitch.on = Global.isHomeSkip
        
        //Set the value of prep stepper
        prepStepper.value = Double(Global.basePrep)
        prepLabel.text = String(Global.basePrep)
        
        
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
    
    @IBAction func primaryStyleValueChanged(sender: AnyObject)
    {
        if (primaryStyleSegControl.selectedSegmentIndex == 0)
        {
            Global.primaryStyle = 0
        }
        else if (primaryStyleSegControl.selectedSegmentIndex == 1)
        {
            Global.primaryStyle = 1
        }
        else if (primaryStyleSegControl.selectedSegmentIndex == 2)
        {
            Global.primaryStyle = 2
        }
        defaults.setInteger(Global.primaryStyle, forKey: "primaryStyle")
    }
    
    @IBAction func homeSkipSwitchValueChanged(sender: AnyObject)
    {
        if (homeSkipSwitch.on)
        {
            Global.isHomeSkip = true
        }
        else
        {
            Global.isHomeSkip = false
        }
        
        defaults.setBool(Global.isHomeSkip, forKey: "isHomeSkip")
    }
    
    @IBAction func prepStepperValueChanged(sender: AnyObject)
    {
        NSLog("Prep value changed")
        
        //Sets the value of base prep to be whatever the stepper is
        Global.basePrep = Int(prepStepper.value)
        prepLabel.text = String(Global.basePrep)
        
        Global.topPrepStarted = false
        Global.topPrepPaused = false
        Global.botPrepStarted = false
        Global.botPrepPaused = false
        
        defaults.setInteger(Global.basePrep, forKey: "basePrep")
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
        if (segue.identifier == "segueSettingsToTimer")
        {
            
        }
    }
    
}
