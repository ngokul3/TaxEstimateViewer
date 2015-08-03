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
    func GetLotsByTerm()-> [LotTerm]
    {
        let lstLotTerm = CapitalGainController.sharedDBInstance.ReturnLotTerm()
        
        return lstLotTerm
    }
    
    func GetTaxableIncome(filingStatus: FilingStatus, lstLotTerm: [LotTerm])
    {
        var lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(filingStatus)
        
      //  var shortTermTaxList : [TaxBracket]
        var shortTermTaxList = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue})
        
        var longTermTaxList = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue})
        
        
        let lotTermMap: [Double] = lstLotTerm.map { return $0.TermRealizedGainLoss }
        let longTermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let shortTermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
      //  let shortTermGL
        
    }
    
   // func GetCapitalGainTax(termGL Float, T
}