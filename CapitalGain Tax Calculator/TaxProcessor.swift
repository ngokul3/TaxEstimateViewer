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
    func GetLotsByTerm(lstLotPosition : [LotPosition])-> [LotTerm]
    {
        let lstLotTerm = CapitalGainController.sharedDBInstance.ReturnLotTerm(lstLotPosition)
        
        return lstLotTerm
    }
    
    func GetTaxableIncome(filingStatus: FilingStatus, lstLotTerm: [LotTerm])
    {
        var lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(filingStatus)
 
        var shortTermTax = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).first
        
        var longTermTax = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).first
        
        
        let lotTermMap: [Double] = lstLotTerm.map { return $0.TermRealizedGainLoss }
        let longTermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let shortTermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let section1256TermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.Section1256.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let longTermGLIncluding1256 = longTermGL + (section1256TermGL * 0.60)
        let shortTermGLIncluding1256 = shortTermGL + (section1256TermGL * 0.40)
        
        if(longTermGLIncluding1256 >= 0 && shortTermGLIncluding1256 >= 0)
        {
            filingStatus.TaxOnLTCapitalGain = GetCapitalGainTax(longTermGL, termTaxDictionary: longTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome)
            filingStatus.TaxOnLTCapitalGain = GetCapitalGainTax(shortTermGL, termTaxDictionary: shortTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome)
            
        }
        else if(longTermGLIncluding1256 < 0 && shortTermGLIncluding1256 >= 0)
        {
            if(longTermGL + shortTermGL > 0)
            {
                filingStatus.TaxOnSTCapitalGain = GetCapitalGainTax(longTermGL + shortTermGL, termTaxDictionary: shortTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome)
            }
            else
            {
                filingStatus.NetLoss = longTermGL + shortTermGL
            }
        }
        else if(longTermGLIncluding1256 >= 0 && shortTermGLIncluding1256 < 0)
        {
            if(longTermGL + shortTermGL > 0)
            {
                filingStatus.TaxOnLTCapitalGain = GetCapitalGainTax(longTermGL + shortTermGL, termTaxDictionary: longTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome)
            }
            else
            {
                filingStatus.NetLoss = longTermGL + shortTermGL
            }
        }
        else if(longTermGLIncluding1256 < 0 && shortTermGLIncluding1256 < 0)
        {
            filingStatus.NetLoss = longTermGL + shortTermGL
        }
        
        filingStatus.TaxOnLTSTCapitalGain = filingStatus.TaxOnLTCapitalGain + filingStatus.TaxOnSTCapitalGain
    }
    
    func GetCapitalGainTax(termGL: Double, termTaxDictionary : TaxBracket, taxableIncome : Double ) -> Double
    {
        var totalIncomeIncludiingCapitalGain : Double
        var taxOnCapitalGain : Double = 0
        var testDict : Dictionary<Double,Double> = Dictionary<Double,Double>()
        
        let cntTaxDictionary = termTaxDictionary.FederalTax.count
        
     //   let xx = termTaxDictionary.FederalTax as Dictionary<Double,Double>!
        let maxTaxValue = termTaxDictionary.FederalTax.array[cntTaxDictionary - 1]
        let maxTaxItem = termTaxDictionary.FederalTax.dictionary[maxTaxValue] //TODO - Double can't be value
        
        totalIncomeIncludiingCapitalGain = taxableIncome + termGL
      
        
        for item in termTaxDictionary.FederalTax.array
        {
            if(item >= taxableIncome)
            {
                let x = totalIncomeIncludiingCapitalGain - item
                
                if(x < 0)
                {
                    let taxOnCapitalGain = taxOnCapitalGain + (termGL * termTaxDictionary.FederalTax.dictionary[item]!)
                    break;
                }
                
                else
                {
                    let taxOnCapitalGain = (item - taxableIncome) * termTaxDictionary.FederalTax.dictionary[item]!
                    let termGL = x
                    let taxableIncome = totalIncomeIncludiingCapitalGain
                    continue
                }
            }
            
            else if (item == maxTaxItem)
            {
                let taxOnCapitalGain = taxOnCapitalGain + (termGL * maxTaxValue)
            }
        }
        
        return taxOnCapitalGain
    }
}