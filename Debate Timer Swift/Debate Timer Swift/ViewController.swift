//
//  ViewController.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/3/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    //Button outlets
    @IBOutlet weak var policyButton: UIButton!
    @IBOutlet weak var ldButton: UIButton!
    @IBOutlet weak var pfdButton: UIButton!
    
    //Variables
    /*struct vcState {
        static var debateChosen = Int()
        static var segueString = "segueToTimer"
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Global.speechCounter = 0
        Global.topCounterCentiseconds = 0
        Global.botCounterCentiseconds = 0
        Global.timerStarted = false
        Global.timerPaused = false
    }
    
    @IBAction func policyButTap(sender: AnyObject)
    {
        Global.debateChosen = 0
        performSegueWithIdentifier(Global.segueString, sender: self)
    }
    @IBAction func ldButTap(sender: AnyObject)
    {
        Global.debateChosen = 1
        performSegueWithIdentifier(Global.segueString, sender: self)
    }
    
    @IBAction func pfdButTap(sender: AnyObject)
    {
        Global.debateChosen = 2
        performSegueWithIdentifier(Global.segueString, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "segueToTimer")
        {
            //Pass variables between View Controllers
            let tVC = segue.destinationViewController as TimerVC
            //tVC.whichDebateChosen = vcState.debateChosen
            
        }
    }
}

