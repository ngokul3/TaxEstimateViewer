//
//  LotTerm.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/29/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

enum ENumTerm:String
{
    case LongTerm = "LongTerm"
    case ShortTerm = "ShortTem"
    case Section1256 = "Section1256"
}
class LotTerm {
    var _year: Int
    var _termRealizedGainLoss : Double
    var _term : ENumTerm
    
    init()
    {
        self._year = 0
        self._termRealizedGainLoss = 0
        self._term = ENumTerm.LongTerm
    }
    
    
}