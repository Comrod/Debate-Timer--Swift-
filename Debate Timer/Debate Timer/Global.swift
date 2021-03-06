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
    static var topPrepStarted = false
    static var topPrepPaused = false
    static var botCounterCentiseconds = Int()
    static var botPrepStarted = false
    static var botPrepPaused = false
    
    //SettingsVC
    static var isCenti = Bool()
    static var basePrep = Int()
    static var primaryStyle = Int()
    static var isHomeSkip = Bool()
}