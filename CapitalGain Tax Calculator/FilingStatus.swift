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
    var _year:Int //ToDO - Int or int32
    var _filingType: ENumFilingType
    var _currentTaxableIncome: Double
    var _previouslyDeferredLoss : Double
    var _taxOnSTCapitalGain: Double
    var _taxOnLTCapitalGain: Double
    var _netLoss : Double
    var _taxOnLTSTCapitalGain : Double
 
    init()
    {
        self._year = 0
        self._filingType = ENumFilingType.Single //TODO: proper init
        self._currentTaxableIncome = 0
        self._previouslyDeferredLoss = 0
        self._taxOnLTCapitalGain = 0
        self._taxOnSTCapitalGain = 0
        self._netLoss = 0
        self._taxOnLTSTCapitalGain = 0
        
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
    
    var TaxOnLTCapitalGain: Double {
        get {
            return _taxOnLTCapitalGain
        }
        set {
            _taxOnLTCapitalGain = newValue
        }
    }
    var TaxOnSTCapitalGain: Double {
        get {
            return _taxOnSTCapitalGain
        }
        set {
            _taxOnSTCapitalGain = newValue
        }
    }
    
    var NetLoss: Double {
        get {
            return _netLoss
            
        }
        set {
            _netLoss = newValue
        }
    }
    
    var TaxOnLTSTCapitalGain: Double {
        get {
            return _taxOnLTSTCapitalGain
        }
        set {
            _taxOnLTSTCapitalGain = newValue
        }
    }
    
    
}