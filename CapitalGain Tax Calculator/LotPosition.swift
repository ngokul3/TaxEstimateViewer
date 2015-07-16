//
//  LotPosition.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

enum Direction{
    case Long, CoveredShort, UnCoveredShort
}

class LotPosition{
    let _lotId:Int
    let _symbolCode:String
    let _symbolDesc:String
    let _openDate: NSDate
    let _closeDate:NSDate
    let _fx:Float
    let _multiplier:Int
    let _lotDirection:Direction
    
    init(lotId:Int, symbolCode:String, symbolDesc:String, openDate:NSDate, closeDate:NSDate, fx:Float, multiplier:Int, lotDirection:Direction
        )
    {
        self._lotId = lotId
        self._symbolCode = symbolCode
        self._symbolDesc = symbolDesc
        self._openDate = openDate
        self._closeDate = closeDate
        self._multiplier = multiplier
        self._fx = fx
        self._lotDirection = lotDirection
        
        
    }
    
}