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
    let _lotId:Int32
    let _symbolCode:String
    let _symbolDesc:String
  /*  let _openDate: NSDate
    let _closeDate:NSDate
    let _fx:Float
    let _multiplier:Int
    let _lotDirection:Direction
    */
   /* init(lotId:Int, symbolCode:String, symbolDesc:String, openDate:NSDate, closeDate:NSDate, fx:Float, multiplier:Int, lotDirection:Direction
    )
 */
    init()
    {
        self._symbolCode = ""
        self._symbolDesc = ""
        self._lotId = 0
    }
    init(lotId:Int32,symbolCode:String,symbolDesc:String
        )
    {
       // self._lotId = lotId
        self._symbolCode = symbolCode
        self._symbolDesc = symbolDesc
        self._lotId = lotId
     /*   self._openDate = openDate
        self._closeDate = closeDate
        self._multiplier = multiplier
        self._fx = fx
        self._lotDirection = lotDirection
        */
        
    }   
    
    
    func GetStockDetail()->String?{
        switch self._symbolCode
        {
            case "AAPL":
            return "Apple"
            
            case "CTSH":
            return "Cogniaznant"
            
        default:
            return "TCS"
            
        }
    }
}