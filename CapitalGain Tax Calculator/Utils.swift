//
//  Utils.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/30/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

class Utils 
{
    private var _filingStatus = FilingStatus()
    private var _lstTaxBracket = [TaxBracket]()
    
    var FilingStatusForGraph: FilingStatus {
        get {
            _filingStatus = CapitalGainController.sharedInstance.GetResultFilingStatus()
            return _filingStatus
        }
        set {
            _filingStatus = newValue
        }
    }
    
    var TaxBracketForGraph: [TaxBracket] {
        get {
            return _lstTaxBracket
        }
        set {
            _lstTaxBracket = newValue
        }
    }
}