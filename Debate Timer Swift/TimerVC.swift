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
    
    //Timer Variables
    var timer = NSTimer()
    var counterCentiseconds = 6000 //1 minute test
    var timercdString = String()
    var timerStarted = false
    
    //Timer Button Variables
    var timerButStartStr = "Start Timer"
    var timerButPauseStr = "Pause Timer"
    var timerButResumeStr = "Resume Timer"
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func timerButTap(sender: AnyObject)
    {
        if (!timerStarted)
        {
            runTimer()
            timerStarted = true
        }
        else
        {
            stopTimer()
            timerButton.setTitle(timerButResumeStr, forState: UIControlState.Normal)
        }
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
            timercdString = String(counterCentiseconds)
            timerLabel.text = timercdString
            
        }
        else
        {
            //Timer has finished (counterCentiseconds has reached 0)
            
            stopTimer()
            NSLog("Timer has finished")
        }
    }
    
    func stopTimer()
    {
        timer.invalidate()
        timerStarted = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}