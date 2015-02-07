//
//  Singleton.swift
//  Debate Timer Swift
//
//  Created by Cormac Chester on 2/7/15.
//  Copyright (c) 2015 Extreme Images. All rights reserved.
//

import Foundation

private let _SingletonSharedInstance = Singleton()

class Singleton {
    
    var centiseconds = Int()
    
    class var sharedInstance: Singleton
    {
        
        return _SingletonSharedInstance
    }
}