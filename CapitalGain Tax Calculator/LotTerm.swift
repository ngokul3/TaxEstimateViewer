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
    case ShortTerm = "ShortTerm"
    case Section1256 = "Section1256"
}
class LotTerm {
    private var _year: Int32
    private var _termRealizedGainLoss : Double
    private var _term : ENumTerm
    
    init()
    {
        self._year = 0
        self._termRealizedGainLoss = 0
        self._term = ENumTerm.LongTerm
    }
    
    var Year: Int32 {
        get {
            return _year
        }
        set {
            _year = newValue
        }
    }
    
    var TermRealizedGainLoss: Double {
        get {
            return _termRealizedGainLoss
        }
        set {
            _termRealizedGainLoss = newValue
        }
    }
    
    var Term: ENumTerm {
        get {
            return _term
        }
        set {
            _term = newValue
        }
    }

    
}