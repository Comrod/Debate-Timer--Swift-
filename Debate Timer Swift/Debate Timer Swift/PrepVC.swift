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
    var timerSelectedTop = Bool()
    
    //Prep Timer
    var prepTimer = NSTimer()
    

    //IB Outlets
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var topPrepTimeLbl: UILabel!
    @IBOutlet weak var topPrepButton: UIButton!
    @IBOutlet weak var topPrepResetButton: UIButton!
    
    @IBOutlet weak var botPrepTimeLbl: UILabel!
    @IBOutlet weak var botPrepButton: UIButton!
    @IBOutlet weak var botPrepResetButton: UIButton!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func backButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueTimerStr, sender: self)
    }
    
    //Top Start Button Tap
    @IBAction func topPrepButTap(sender: AnyObject)
    {
        
    }
    
    //Top Reset Button Tap
    @IBAction func topPrepResetButTap(sender: AnyObject)
    {
        
    }
    
    //Bot Start Button Tap
    @IBAction func botPrepButTap(sender: AnyObject)
    {
        
    }
    
    //Bot Reset Button Tap
    @IBAction func botPrepResetButTap(sender: AnyObject)
    {
        
    }
    
    
    
    //MARK: - Timer Code
    
    //Runs Prep Timer
    func runPrepTimer()
    {
        prepTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updatePrepCounter"), userInfo: nil, repeats: true)
        
    }
    
    //Updates Prep Counter
    func updatePrepCounter()
    {
        if (timerSelectedTop)
        {
            if (Global.topCounterCentiseconds > 0)
            {
                Global.topCounterCentiseconds--
            }
            else //When the timer has finshed
            {
                
            }
        }
        else
        {
            if (Global.botCounterCentiseconds > 0)
            {
                Global.botCounterCentiseconds--
            }
            else //When the timer has finished
            {
                
            }
        }
    }
    
    func stopPrepTimer()
    {
        prepTimer.invalidate()
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
            let tVC = segue.destinationViewController as TimerVC
        }
    }
}

