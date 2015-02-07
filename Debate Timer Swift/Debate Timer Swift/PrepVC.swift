//
//  PrepVC.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/6/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit

class PrepVC: UIViewController {
    
    var segueTimerStr = "seguePrepToTimer"
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func backButTap(sender: AnyObject)
    {
        performSegueWithIdentifier(segueTimerStr, sender: self)
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

