//
//  PrepVC.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/6/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class PrepVC: UIViewController {
    
    //Variables
    var segueTimerStr = "seguePrepToTimer"
    var topTimerSelected = Bool()
    var styleLblStr = String()
    
    //Prep Timer
    var prepTimer = NSTimer()
    var topTimerCDStr = String()
    var botTimerCDStr = String()
    
    var prepButStartStr = "Start"
    var prepButPauseStr = "Pause"
    var prepButResumeStr = "Resume"

    //Object for playing sound
    var pSound = PlaySound()
    
    //IB Outlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var styleLabel: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topPrepTimeLbl: UILabel!
    @IBOutlet weak var topPrepButton: UIButton!
    @IBOutlet weak var topPrepResetButton: UIButton!
    
    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var botPrepTimeLbl: UILabel!
    @IBOutlet weak var botPrepButton: UIButton!
    @IBOutlet weak var botPrepResetButton: UIButton!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (Global.debateChosen < 2)//Policy or LD chosen
        {
            topLabel.text = "Aff Prep Time"
            botLabel.text = "Neg Prep Time"
        }
        else//PFD chosen
        {
            topLabel.text = "Pro Prep Time"
            botLabel.text = "Con Prep Time"
        }
        
        if (Global.debateChosen == 0)
        {
            styleLblStr = "Policy Debate"
            
        }
        else if (Global.debateChosen == 1)
        {
            styleLblStr = "Lincoln-Douglas Debate"
        }
        else if (Global.debateChosen == 2)
        {
            styleLblStr = "Public Forum Debate"
        }

        styleLabel.text = styleLblStr
        
        //Hardcoding right now, will fix later
        if (!Global.topPrepStarted)
        {
            setTopPrepTimer()
            NSLog("Setting top prep")
        }
        else
        {
            topPrepButton.setTitle(prepButResumeStr, forState: UIControlState.Normal)
        }
        
        
        if (!Global.botPrepStarted)
        {
            setBotPrepTimer()
            NSLog("Setting bot prep")
        }
        else
        {
            botPrepButton.setTitle(prepButResumeStr, forState: UIControlState.Normal)
        }
        
        //Sets Prep Timer Labels
        setTopPrepTimerLabel()
        setBotPrepTimerLabel()
    }
    
    @IBAction func backButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueTimerStr, sender: self)
    }
    
    //Top Start Button Tap
    @IBAction func topPrepButTap(sender: AnyObject)
    {
        //Stop bot prep timer if it is running
        if (Global.botPrepStarted)
        {
            Global.botPrepPaused = true
            stopPrepTimer()
            botPrepButton.setTitle(prepButResumeStr, forState: UIControlState.Normal)
        }
        
        topTimerSelected = true
        
        if (!Global.topPrepStarted)//If top prep timer has not started yet
        {
            runPrepTimer()
            Global.topPrepStarted = true
            topPrepButton.setTitle(prepButPauseStr, forState: UIControlState.Normal)
        }
        else
        {
            if (Global.topPrepPaused)//If timer is paused
            {
                topTimerSelected = true
                Global.topPrepPaused = false
                topPrepButton.setTitle(prepButPauseStr, forState: UIControlState.Normal)
                runPrepTimer()
            }
            else
            {
                stopPrepTimer()
                topPrepButton.setTitle(prepButResumeStr, forState: UIControlState.Normal)
                Global.topPrepPaused = true
            }
        }
    }
    
    //Top Reset Button Tap
    @IBAction func topPrepResetButTap(sender: AnyObject)
    {
        topTimerSelected = true
        Global.topPrepStarted = false
        Global.topPrepPaused = false
        stopPrepTimer()
        topPrepButton.setTitle(prepButStartStr, forState: UIControlState.Normal)
        setTopPrepTimer()
        setTopPrepTimerLabel()
        
    }
    
    //Bot Start Button Tap
    @IBAction func botPrepButTap(sender: AnyObject)
    {
        if (Global.topPrepStarted)
        {
            Global.topPrepPaused = true
            stopPrepTimer()
            topPrepButton.setTitle(prepButResumeStr, forState: UIControlState.Normal)
        }
        
        topTimerSelected = false
        
        if (!Global.botPrepStarted)
        {
            Global.botPrepStarted = true
            runPrepTimer()
            botPrepButton.setTitle(prepButPauseStr, forState: UIControlState.Normal)
        }
        else
        {
            if (Global.botPrepPaused)
            {
                topTimerSelected = false
                Global.botPrepPaused = false
                botPrepButton.setTitle(prepButPauseStr, forState: UIControlState.Normal)
                runPrepTimer()
            }
            else
            {
                stopPrepTimer()
                botPrepButton.setTitle(prepButResumeStr, forState: UIControlState.Normal)
                Global.botPrepPaused = true
            }
        }
    }
    
    //Bot Reset Button Tap
    @IBAction func botPrepResetButTap(sender: AnyObject)
    {
        topTimerSelected = false
        Global.botPrepStarted = false
        Global.topPrepPaused = false
        stopPrepTimer()
        botPrepButton.setTitle(prepButStartStr, forState: UIControlState.Normal)
        setBotPrepTimer()
        setBotPrepTimerLabel()
    }
    
    
    //MARK: - Timer Code
    
    func setTopPrepTimer()
    {
        Global.topCounterCentiseconds = Global.basePrep*6000
    }
    
    func setBotPrepTimer()
    {
        Global.botCounterCentiseconds = Global.basePrep*6000
    }
    
    //Runs Prep Timer
    func runPrepTimer()
    {
        prepTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updatePrepCounter"), userInfo: nil, repeats: true)
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    //Updates Prep Counter
    func updatePrepCounter()
    {
        if (topTimerSelected)
        {
            if (Global.topCounterCentiseconds > 0)
            {
                Global.topCounterCentiseconds--
                setTopPrepTimerLabel()
            }
            else //When the timer has finshed
            {
                stopPrepTimer()
                Global.topPrepStarted = false
                Global.topPrepPaused = false
                setTopPrepTimer()
                setTopPrepTimerLabel()
                topPrepButton.setTitle(prepButStartStr, forState: UIControlState.Normal)
                
                //Play sound
                pSound.playSound()
                NSLog("Played sound")
                
                //Show Alert
                var newTimerAlert = UIAlertView(title: "Timer Done", message: "Prep is finished", delegate: nil, cancelButtonTitle: "Ok")
                newTimerAlert.show()
                
                NSLog("Top prep time finished")
            }
        }
        else
        {
            if (Global.botCounterCentiseconds > 0)
            {
                Global.botCounterCentiseconds--
                setBotPrepTimerLabel()
            }
            else //When the timer has finished
            {
                stopPrepTimer()
                Global.botPrepStarted = false
                Global.botPrepPaused = false
                setBotPrepTimer()
                setBotPrepTimerLabel()
                botPrepButton.setTitle(prepButStartStr, forState: UIControlState.Normal)
                
                //Play sound
                pSound.playSound()
                NSLog("Played sound")
                
                //Show alert
                var newTimerAlert = UIAlertView(title: "Timer Done", message: "Prep is finished", delegate: nil, cancelButtonTitle: "Ok")
                newTimerAlert.show()
                
                NSLog("Bot prep time finished")
            }
        }
    }
    
    func setTopPrepTimerLabel()
    {
        var topCentiseconds = Global.topCounterCentiseconds % 100
        var topSeconds = (Global.topCounterCentiseconds / 100) % 60
        var topMinutes = (Global.topCounterCentiseconds / 100) / 60
        
        if (Global.topPrepStarted)
        {
            if (Global.isCenti)
            {
                topTimerCDStr = String(format: "%02d:%02d:%02d", topMinutes, topSeconds, topCentiseconds)
            }
            else
            {
                topTimerCDStr = String(format: "%02d:%02d", topMinutes, topSeconds)
            }
            
        }
        else
        {
            if (Global.isCenti)
            {
                topTimerCDStr = String(format:"%02d:00:00", topMinutes)
            }
            else
            {
                topTimerCDStr = String(format:"%02d:00", topMinutes)
            }
            
        }
        
        topPrepTimeLbl.text = topTimerCDStr
    }
    
    func setBotPrepTimerLabel()
    {
        var botCentiseconds = Global.botCounterCentiseconds % 100
        var botSeconds = (Global.botCounterCentiseconds / 100) % 60
        var botMinutes = (Global.botCounterCentiseconds / 100) / 60
        
        if (Global.botPrepStarted)
        {
            if (Global.isCenti)
            {
                botTimerCDStr = String(format: "%02d:%02d:%02d", botMinutes, botSeconds, botCentiseconds)
            }
            else
            {
                botTimerCDStr = String(format: "%02d:%02d", botMinutes, botSeconds)
            }
        }
        else
        {
            if (Global.isCenti)
            {
                botTimerCDStr = String(format:"%02d:00:00", botMinutes)
            }
            else
            {
                botTimerCDStr = String(format:"%02d:00", botMinutes)
            }
        }
        
        botPrepTimeLbl.text = botTimerCDStr
    }
    
    func stopPrepTimer()
    {
        prepTimer.invalidate()
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //If going back to the debate selection screen
        if (segue.identifier == "seguePrepToTimer")
        {
            if (Global.topPrepStarted)
            {
                stopPrepTimer()
                Global.topPrepPaused = true
            }
            
            if (Global.botPrepStarted)
            {
                stopPrepTimer()
                Global.botPrepPaused = true
            }
            
            //Pass variables between View Controllers
            let tVC = segue.destinationViewController as! TimerVC
        }
    }
}

