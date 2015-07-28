//
//  FilingMode.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/27/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

enum ENumFilingType:String{
    case Single = "Single"
    case Joint = "Joint"
    case HoH = "Head Of Household"
    case Separate = "Separate"
}

class FilingStatus
{
    var _year:Int
    var _filingType: ENumFilingType
    var _currentTaxableIncome: Double
    var _previouslyDeferredLoss : Double
 
    init()
    {
        self._year = 0
        self._filingType = ENumFilingType.Single
        self._currentTaxableIncome = 0
        self._previouslyDeferredLoss = 0
        
        
    }
    
    
    var Year: Int {
        get {
            return _year
        }
        set {
            _year = newValue
        }
    }
    
    var FilingType: ENumFilingType {
        get {
            return _filingType
        }
        set {
            _filingType = newValue
        }
    }
    
    var CurrentTaxableIncome: Double {
        get {
            return _currentTaxableIncome
        }
        set {
            _currentTaxableIncome = newValue
        }
    }
    
    var PreviouslyDeferredLoss: Double {
        get {
            return _previouslyDeferredLoss
        }
        set {
            _previouslyDeferredLoss = newValue
        }
    }
    
    
}