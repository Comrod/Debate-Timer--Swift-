//
//  TimerVC.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/3/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    //Debate Variables
    var whichDebateChosen = Int()
    var policyTimes: [Int] = [8, 3, 8, 3, 8, 3, 8, 3, 5, 5, 5, 5]
    var ldTimes: [Int] = [6, 3, 7, 3, 4, 6, 3]
    var pfdTimes: [Int] = [1, 4, 3, 4, 4, 3, 2, 2, 3, 2, 2]
    
    //Timer Variables
    var timer = NSTimer()
    var counterCentiseconds = Int()
    var speechCounter = 0
    var timercdString = String()
    var timerStarted = false
    
    //Timer Button Variables
    var timerButStartStr = "Start Timer"
    var timerButPauseStr = "Pause Timer"
    var timerButResumeStr = "Resume Timer"
    
    //Other Variables
    var segueHomeStr = "segueToHome"
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set timer data
        setTimerData()
        
        NSLog("Debate chosen: \(whichDebateChosen)")
        
        setTimerLabel()
        
    }
    
    
    @IBAction func timerButTap(sender: AnyObject)
    {
        if (!timerStarted)
        {
            runTimer()
            timerStarted = true
            NSLog("Starting Timer")
        }
        else
        {
            stopTimer()
            timerButton.setTitle(timerButResumeStr, forState: UIControlState.Normal)
            NSLog("Pausing Timer")
        }
    }
    
    @IBAction func backButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueHomeStr, sender: self)
    }
    
    
    //Runs the timer
    func runTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateCounter"), userInfo: nil, repeats: true)
        timerButton.setTitle(timerButPauseStr, forState: UIControlState.Normal)
    }
    
    //Actual timer method - reduces the counter until counter = 0
    func updateCounter()
    {
        if (counterCentiseconds > 0)
        {
            //Reduce counter
            counterCentiseconds--
            
            //Update label
            setTimerLabel()
            
        }
        else
        {
            //Timer has finished (counterCentiseconds has reached 0)
            
            stopTimer()
            
            speechCounter++
            
            timerStarted = false
            
            setTimerData() //Sets timer for next speech
            setTimerLabel() //Sets timer label minute place for the next speech
            timerButton.setTitle(timerButStartStr, forState: UIControlState.Normal) //Sets timer button to be "Start Timer"
            
            NSLog("Timer has finished")
        }
    }
    
    func stopTimer()
    {
        timer.invalidate()
        timerStarted = false
    }
    
    func setTimerData()
    {
        if (whichDebateChosen == 0)
        {
            counterCentiseconds = (policyTimes[speechCounter] * 6000)
        }
        else if (whichDebateChosen == 1)
        {
            counterCentiseconds = (ldTimes[speechCounter] * 6000)
        }
        else if (whichDebateChosen == 2)
        {
            counterCentiseconds = (pfdTimes[speechCounter] * 6000)
        }
        
        NSLog("counter centiseconds: \(counterCentiseconds)")
    }
    
    //Sets the timer label - is called by updateCounter and viewDidLoad
    func setTimerLabel()
    {
        var centiseconds = counterCentiseconds % 100
        var seconds = (counterCentiseconds / 100) % 60
        var minutes = (counterCentiseconds / 100) / 60
        if (timerStarted)
        {
            //When the timer has started
            timercdString = String(format: "%02d:%02d:%02d", minutes, seconds, centiseconds)
        }
        else
        {
            timercdString = String(format:"%02d:00:00", minutes)
            NSLog("Base timer label set; centiseconds: \(minutes)")
        }
        
        timerLabel.text = timercdString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //If going back to the debate selection screen
        if (segue.identifier == "segueToHome")
        {
            //Pass variables between View Controllers
            let vC = segue.destinationViewController as ViewController
            
            
        }
    }
    
}