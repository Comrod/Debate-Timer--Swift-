//
//  ViewController.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/3/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    //Button outlets
    @IBOutlet weak var policyButton: UIButton!
    @IBOutlet weak var ldButton: UIButton!
    @IBOutlet weak var pfdButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Global.speechCounter = 0
        Global.topPrepStarted = false
        Global.botPrepStarted = false
        Global.timerStarted = false
        Global.timerPaused = false

        
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        //If homeskipping is on
        if (defaults.boolForKey("isFirstLaunch"))
        {
            NSLog("Is First Launch")
            if (Global.isHomeSkip)
            {
                //Moves straight to timer with primary style of debate
                Global.debateChosen = Global.primaryStyle
                NSLog("Running homeskip")
                performSegueWithIdentifier(Global.segueString, sender: self)
            }
        }
    }
    
    @IBAction func policyButTap(sender: AnyObject)
    {
        Global.debateChosen = 0
        
        if (!Global.openedBefore)
        {
            Global.basePrep = 5
        }
        performSegueWithIdentifier(Global.segueString, sender: self)
    }
    @IBAction func ldButTap(sender: AnyObject)
    {
        Global.debateChosen = 1
        if (!Global.openedBefore)
        {
            Global.basePrep = 4
        }
        performSegueWithIdentifier(Global.segueString, sender: self)
    }
    
    @IBAction func pfdButTap(sender: AnyObject)
    {
        Global.debateChosen = 2
        
        if (!Global.openedBefore)
        {
            Global.basePrep = 2
        }
        performSegueWithIdentifier(Global.segueString, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "segueToTimer")
        {
            defaults.setBool(true, forKey: "openedBefore")
            Global.openedBefore = defaults.boolForKey("openedBefore")
            
            
            //Pass variables between View Controllers
            let tVC = segue.destinationViewController as TimerVC
            
        }
    }
}

