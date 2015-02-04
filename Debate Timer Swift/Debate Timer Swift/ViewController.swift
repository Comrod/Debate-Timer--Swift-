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

    var debateChosen = Int()
    var segueString = "segueToTimer"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func policyButTap(sender: AnyObject)
    {
        debateChosen = 0
        //performSegueWithIdentifier("segueToTimer", sender: AnyObject)
        performSegueWithIdentifier(segueString, sender: self)
    }
    @IBAction func ldButTap(sender: AnyObject)
    {
        debateChosen = 1
        performSegueWithIdentifier(segueString, sender: self)
    }
    
    @IBAction func pfdButTap(sender: AnyObject)
    {
        debateChosen = 2
        performSegueWithIdentifier(segueString, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toTimerSegue")
        {
            //Pass variables between View Controllers
            let tVC = segue.destinationViewController as TimerVC
            tVC.whichDebateChosen = debateChosen
            
        }
    }
}

