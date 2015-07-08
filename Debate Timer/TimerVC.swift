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
    var policyTimes: [Int] = [8, 3, 8, 3, 8, 3, 8, 3, 5, 5, 5, 5, 0]
    var policySpeeches: [String] = ["1AC", "CX", "1NC", "CX", "2AC", "CX", "2NC", "CX", "1NR", "1AR", "2NR", "2AR", "Round Finished"]
    var ldTimes: [Int] = [6, 3, 7, 3, 4, 6, 3, 0]
    var ldSpeeches: [String] = ["AC", "CX", "NC (1NR)", "CX", "1AR", "NR (2NR)", "2AR", "Round Finished"]
    var pfdTimes: [Int] = [4, 4, 3, 4, 4, 3, 2, 2, 3, 2, 2, 0]
    var pfdSpeeches: [String] = ["Team A Constructive", "Team B Constructive", "Crossfire", "Team A Rebuttal", "Team B Rebuttal", "Crossfire", "Team A Summary", "Team B Summary", "Grand Crossfire", "Team A Final", "Team B Final", "Round Finished"]
    
    //Timer Variables
    var timer = NSTimer()
    //var counterCentiseconds = Int()
    //var speechCounter = 0
    var timercdString = String()
    //var timerStarted = false
    
    //Object for playing sound
    var pSound = PlaySound()
    
    //Timer Button Variables
    var timerButStartStr = "Start Timer"
    var timerButPauseStr = "Pause Timer"
    var timerButResumeStr = "Resume Timer"
    
    //Picker View
    var pickerData: [String] = Array()
    var isPickerShowing = Bool()
    
    //Other Variables
    var segueHomeStr = "segueToHome"
    var seguePrepStr = "segueToPrep"
    var segueSettingsStr = "segueToSettings"
    var speechLblStr = String()
    var styleLblStr = String()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var showPickerButton: UIButton!
    @IBOutlet weak var speechPicker: UIPickerView!
    @IBOutlet weak var prepButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSLog("Debate chosen: \(Global.debateChosen), Speech counter: \(Global.speechCounter), Centiseconds: \(Global.counterCentiseconds)")
        
        defaults.setBool(false, forKey: "isFirstLaunch")
        
        
        //If the timer hasn't started
        if (!Global.timerStarted)
        {
            //Set timer data
            setTimerData()
            NSLog("Timer has not started so resetting data")
        }
        else
        {
            //Sets the Timer Button to "Resume Timer"
            timerButton.setTitle(timerButResumeStr, forState: UIControlState.Normal)
        }
        
        //Sets prep time
        if (!Global.topPrepStarted)
        {
            Global.topCounterCentiseconds = Global.basePrep*6000
            NSLog("top prep is reset in timervc")
        }
        
        if (!Global.botPrepStarted)
        {
            Global.botCounterCentiseconds = Global.basePrep*6000
        }
        
        //Sets picker data
        setPickerData()
        
        //Sets labels
        setTimerLabel()
        setSpeechLabel()
        
        //Sets picker to appear offscreen
        speechPicker.center = CGPointMake(speechPicker.center.x, speechPicker.center.y + self.view.frame.size.height)
        isPickerShowing = false
        
        NSLog("Timer Started: \(Global.timerStarted)")
        
    }
    @IBAction func timerButTap(sender: AnyObject)
    {

        if (!Global.timerStarted) //If the timer has not started
        {
            if (Global.counterCentiseconds > 0)
            {
                runTimer()
                Global.timerStarted = true
                NSLog("Starting Timer")
            }
            else //Round is over because countercentiseconds will only be 0 when the last speech has finished
            {
                var newTimerAlert = UIAlertView(title: "Round is Over", message: "Round is over, you've been sent back to the selection screen", delegate: nil, cancelButtonTitle: "Ok")
                newTimerAlert.show()
                performSegueWithIdentifier(segueHomeStr, sender: self)
            }
        }
        else
        {
            if (Global.timerPaused) //If the timer is paused (from going to another view)
            {
                runTimer()
            }
            else //If the timer is running (not paused)
            {
                stopTimer()
                timerButton.setTitle(timerButResumeStr, forState: UIControlState.Normal)
                Global.timerPaused = true
                NSLog("Pausing Timer")
            }
        }
    }
    
    @IBAction func resetButTap(sender: AnyObject)
    {
        Global.timerStarted = false
        Global.timerPaused = false
        stopTimer()
        timerButton.setTitle(timerButStartStr, forState: UIControlState.Normal)
        setTimerData()
        setTimerLabel()
    }
    
    
    @IBAction func backButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueHomeStr, sender: self)
    }
    
    @IBAction func settingsButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueSettingsStr, sender: self)
    }
    
    
    
    //Runs the timer
    func runTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateCounter"), userInfo: nil, repeats: true)
        timerButton.setTitle(timerButPauseStr, forState: UIControlState.Normal)
        
        Global.timerPaused = false
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    //Actual timer method - reduces the counter until counter = 0
    func updateCounter()
    {
        if (Global.counterCentiseconds > 0)
        {
            //Reduce counter
            Global.counterCentiseconds--
            
            //Update label
            setTimerLabel()
            
        }
        else
        {
            //Timer has finished (counterCentiseconds has reached 0)
            
            stopTimer()
            
            Global.speechCounter++
            
            Global.timerStarted = false
            
            setTimerData() //Sets timer for next speech
            setTimerLabel() //Sets timer label minute place for the next speech
            setSpeechLabel()
            timerButton.setTitle(timerButStartStr, forState: UIControlState.Normal) //Sets timer button to be "Start Timer"
            
            //Play sound and show alert
            pSound.playSound()
            NSLog("Played sound")
            
            var newTimerAlert = UIAlertView(title: "Timer Done", message: "Speech is finished", delegate: nil, cancelButtonTitle: "Ok")
            newTimerAlert.show()
            
            NSLog("Timer has finished")
        }
    }
    
    func stopTimer()
    {
        timer.invalidate()
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    func setTimerData()
    {
        if (Global.debateChosen == 0)
        {
            Global.counterCentiseconds = (policyTimes[Global.speechCounter] * 6000)
        }
        else if (Global.debateChosen == 1)
        {
            Global.counterCentiseconds = (ldTimes[Global.speechCounter] * 6000)
        }
        else if (Global.debateChosen == 2)
        {
            Global.counterCentiseconds = (pfdTimes[Global.speechCounter] * 6000)
        }
        
        NSLog("counter centiseconds: \(Global.counterCentiseconds)")
    }
    
    //Sets the timer label - is called by updateCounter and viewDidLoad
    func setTimerLabel()
    {
        var centiseconds = Global.counterCentiseconds % 100
        var seconds = (Global.counterCentiseconds / 100) % 60
        var minutes = (Global.counterCentiseconds / 100) / 60
        if (Global.timerStarted)
        {
            //When the timer has started
            if (Global.isCenti)
            {
                timercdString = String(format: "%02d:%02d:%02d", minutes, seconds, centiseconds)
            }
            else
            {
                timercdString = String(format: "%02d:%02d", minutes, seconds)
            }
            
        }
        else
        {
            if (Global.isCenti)
            {
                timercdString = String(format:"%02d:00:00", minutes)
            }
            else
            {
                timercdString = String(format:"%02d:00", minutes)
            }
            
            NSLog("Base timer label set; Minutes: \(minutes)")
        }
        
        timerLabel.text = timercdString
        
    }
    
    func setSpeechLabel()
    {
        if (Global.debateChosen == 0)
        {
            speechLblStr = policySpeeches[Global.speechCounter]
            styleLblStr = "Policy Debate"
            
        }
        else if (Global.debateChosen == 1)
        {
            speechLblStr = ldSpeeches[Global.speechCounter]
            styleLblStr = "Lincoln-Douglas Debate"
        }
        else if (Global.debateChosen == 2)
        {
            speechLblStr = pfdSpeeches[Global.speechCounter]
            styleLblStr = "Public Forum Debate"
        }
        
        speechLabel.text = speechLblStr
        styleLabel.text = styleLblStr
    }
    
    //Prep Time Button
    @IBAction func prepButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(seguePrepStr, sender: self)
    }
    
    
    //Picker for choosing speech
    @IBAction func showPickerButTap(sender: AnyObject)
    {
        
        if (!isPickerShowing)
        {
            showPicker()
            NSLog("Shows picker")
        }
        else if (isPickerShowing)
        {
            hidePicker()
            NSLog("Shows picker")
        }
        
        NSLog("New Picker Pos: \(speechPicker.center)")
    }
    
    //Shows picker from off-screen
    func showPicker()
    {
        //Sets picker to selected row
        speechPicker.selectRow(Global.speechCounter, inComponent: 0, animated: true)
        showPickerButton.setTitle("Hide Speeches", forState: UIControlState.Normal)
        
        //Animates the picker
        var mainPickerCenter = CGPointMake(speechPicker.center.x, speechPicker.center.y - self.view.frame.size.height)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        speechPicker.center = mainPickerCenter
        
        UIView.commitAnimations()
        isPickerShowing = true
    }
    
    //Hides picker off-screen
    func hidePicker()
    {
        showPickerButton.setTitle("Show Speeches", forState: UIControlState.Normal)
        
        var newPickerCenter = CGPointMake(speechPicker.center.x, speechPicker.center.y + self.view.frame.size.height)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        speechPicker.center = newPickerCenter
        
        UIView.commitAnimations()
        isPickerShowing = false
    }
    
    //Sets data for picker
    func setPickerData()
    {
        if (Global.debateChosen == 0)
        {
            pickerData = policySpeeches
        }
        else if (Global.debateChosen == 1)
        {
            pickerData = ldSpeeches
        }
        else if (Global.debateChosen == 2)
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
        
        return pickerData[row]
    }
    
    //When a row in the picker is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //Effectively resets the timer because a new speech has been selected
        Global.speechCounter = row
        if (Global.timerStarted){
            stopTimer()
            Global.timerStarted = false
        }
        setTimerData()
        setTimerLabel()
        setSpeechLabel()
        timerButton.setTitle(timerButStartStr, forState: UIControlState.Normal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //If going back to the debate selection screen
        if (segue.identifier == "segueToHome")
        {
            stopTimer()
            
            //Pass variables between View Controllers
            let vC = segue.destinationViewController as! ViewController
            
        }
        else if (segue.identifier == "segueToPrep") //If going to prep vc
        {
            if (Global.timerStarted)
            {
                Global.timerPaused = true
                stopTimer()
            }
            
            let pVC = segue.destinationViewController as! PrepVC
            
        }
        else if (segue.identifier == "segueToSettings")
        {
            if (Global.timerStarted)
            {
                Global.timerPaused = true
                stopTimer()
            }
        }
    }
    
}