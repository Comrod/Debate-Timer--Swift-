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
    var homeSkipDelay = NSTimer()
    var delayIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 200, 200)) as UIActivityIndicatorView
    
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

        //Delay Indicator for home skipping
        delayIndicator.bounds = self.view.frame
        delayIndicator.center = self.view.center
        delayIndicator.alpha = 0.5
        delayIndicator.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        delayIndicator.hidesWhenStopped = true
        delayIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        delayIndicator.transform = CGAffineTransformMakeScale(1.5, 1.5)//Scales up the delay indicator
    }
    
    override func viewDidAppear(animated: Bool)
    {
        //If homeskipping is on
        if (defaults.boolForKey("isFirstLaunch"))
        {
            Global.isHomeSkip = defaults.boolForKey("isHomeSkip")
            Global.primaryStyle = defaults.integerForKey("primaryStyle")
            NSLog("Is First Launch")
            
            if (Global.isHomeSkip)
            {
                view.addSubview(delayIndicator)
                delayIndicator.startAnimating()
                homeSkipDelay = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: ("doHomeSkip"), userInfo: nil, repeats: false)
            }
        }
    }
    
    func doHomeSkip()//Moves straight to timer with primary style of debate
    {
        Global.debateChosen = Global.primaryStyle
        NSLog("Running homeskip")
        delayIndicator.stopAnimating()
        performSegueWithIdentifier(Global.segueString, sender: self)
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

