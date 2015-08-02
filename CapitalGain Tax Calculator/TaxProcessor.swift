//
//  TaxProcessor.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/29/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

class TaxProcessor
{
    init()
    {
        TaxOnCapitalGainLossUp.LoadFederalTax()
        
    }
    func GetLotsByTerm()-> NSMutableArray
    {
        var arrayLotTerm = NSMutableArray()
        arrayLotTerm = CapitalGainController.sharedDBInstance.ReturnLotTerm()
        
        return arrayLotTerm
    }
    
    func GetTaxableIncome(filingStatus: FilingStatus, arrayLotPosition: NSMutableArray)
    {
        var lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(filingStatus)
        
        var ShortTermTaxList = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue})
        
        var LongTermTaxList = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue})
    }
    
   // func GetCapitalGainTax(termGL Float, T
}