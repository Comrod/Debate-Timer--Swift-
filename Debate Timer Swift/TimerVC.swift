//
//  TimerVC.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/3/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    //call setSpeechLabel
    
    //Debate Variables
    var whichDebateChosen = Int()
    var policyTimes: [Int] = [8, 3, 8, 3, 8, 3, 8, 3, 5, 5, 5, 5, 0]
    var policySpeeches: [String] = ["1AC", "CX", "1NC", "CX", "2AC", "CX", "2NC", "CX", "1NR", "1AR", "2NR", "2AR", "Round Finished"]
    var ldTimes: [Int] = [6, 3, 7, 3, 4, 6, 3, 0]
    var ldSpeeches: [String] = ["AC", "CX", "NC (1NR)", "CX", "1AR", "NR (2NR)", "2AR", "Round Finished"]
    var pfdTimes: [Int] = [1, 4, 3, 4, 4, 3, 2, 2, 3, 2, 2, 0]
    var pfdSpeeches: [String] = ["Team A Constructive", "Team B Constructive", "Crossfire", "Team A Rebuttal", "Team B Rebuttal", "Crossfire", "Team A Summary", "Team B Summary", "Grand Crossfire", "Team A Final", "Team B Final", "Round Finished"]
    
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
    
    //Picker View
    var pickerData: [String] = Array()
    
    //Other Variables
    var segueHomeStr = "segueToHome"
    var speechLblStr = String()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set timer data
        setTimerData()

        NSLog("Debate chosen: \(whichDebateChosen)")
        
        //Sets picker data
        setPickerData()
        
        setTimerLabel()
        setSpeechLabel()
        
    }
    
    
    @IBAction func timerButTap(sender: AnyObject)
    {
        if (!timerStarted)
        {
            if (counterCentiseconds > 0)
            {
                runTimer()
                timerStarted = true
                NSLog("Starting Timer")
            }
            else
            {
                //Round is over because countercentiseconds will only be 0 when the last speech has finished
                performSegueWithIdentifier(segueHomeStr, sender: self)
            }
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
            setSpeechLabel()
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
    
    func setSpeechLabel()
    {
        if (whichDebateChosen == 0)
        {
            speechLblStr = policySpeeches[speechCounter]
        }
        else if (whichDebateChosen == 1)
        {
            speechLblStr = ldSpeeches[speechCounter]
        }
        else if (whichDebateChosen == 2)
        {
            speechLblStr = pfdSpeeches[speechCounter]
        }
        
        speechLabel.text = speechLblStr
    }
    
    //Picker for choosing speech
    
    //Sets data for picker
    func setPickerData()
    {
        if (whichDebateChosen == 0)
        {
            pickerData = policySpeeches
        }
        else if (whichDebateChosen == 1)
        {
            pickerData = ldSpeeches
        }
        else if (whichDebateChosen == 2)
        {
            pickerData = pfdSpeeches
        }
    }
    
    //Number of columns in picker
    func numberOfComponentsInPickerView(picker: UIPickerView) -> Int
    {
        return 1
    }
    
    //Set number of rows in picker
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    //Sets data to picker
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        NSLog("Picker: \(pickerData[row])")
        
        speechCounter = row
        if (timerStarted){
            stopTimer()
        }
        setTimerData()
        setTimerLabel()
        setSpeechLabel()
        
        return pickerData[row]
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