//
//  Global.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/9/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import Foundation

struct Global {
    
    //ViewController
    static var debateChosen = Int()
    static var segueString = "segueToTimer"
    
    //TimerVC
    static var counterCentiseconds = Int()
    static var speechCounter = Int()
    static var timerStarted = false
    static var timerPaused = false
    
    //PrepVC
    static var topCounterCentiseconds = Int()
    static var botCounterCentiseconds = Int()
}