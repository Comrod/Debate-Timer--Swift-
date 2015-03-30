//
//  PlaySound.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 3/26/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import UIKit
import AudioToolbox

class PlaySound
{
    //Timer Sound
    let timerSoundURL = NSBundle.mainBundle().URLForResource("alarm", withExtension: "caf")
    var timerSoundID: SystemSoundID = 0
    
    func playSound()
    {
        AudioServicesCreateSystemSoundID(timerSoundURL, &timerSoundID)
        AudioServicesPlaySystemSound(timerSoundID)
        NSLog("Played sound")
    }
}

