//
//  TaxBracket.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/1/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

class TaxBracket
{
    private var _year: Int32
    private var _term: ENumTerm
    private var _filingType: ENumFilingType
    private var _federalTax: Dictionary<Double,Double>
    
    init()
    {
        self._year = 0
        self._term = ENumTerm.LongTerm //ToDo - better init
        self._filingType = ENumFilingType.Separate //ToDo - better init

        self._federalTax = Dictionary<Double,Double>()
        
        
    }
    
    var Year: Int32 {
        get {
            return _year
        }
        set {
            _year = newValue
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
    
    var FilingType: ENumFilingType{
        get {
            return _filingType
        }
        set {
            _filingType = newValue
        }
    }

    var FederalTax: Dictionary<Double,Double> {
        get {
            return _federalTax
        }
        set {
            _federalTax = newValue
        }
    }

    
}