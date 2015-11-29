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
  
    
    func GetTaxableIncome(filingStatus: FilingStatus, lstLotTerm: [LotTerm]) -> FilingStatus
    {
        filingStatus.FilingStatusTax = [FilingStatusTaxAt]()
        filingStatus.TaxOnLTCapitalGain = 0
        filingStatus.TaxOnLTCapitalGain = 0
        filingStatus.TaxOnSTCapitalGain = 0
        
        let lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(filingStatus)
 
        let shortTermTax = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).first
        
        let longTermTax = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).first
        
        
    //    let lotTermMap: [Double] = lstLotTerm.map { return $0.TermRealizedGainLoss }
        let longTermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let shortTermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let section1256TermGL = lstLotTerm.filter({m in m.Term.rawValue == ENumTerm.Section1256.rawValue}).map { return $0.TermRealizedGainLoss }.reduce(0) { return $0 + $1 }
        
        let longTermGLIncluding1256 = longTermGL + (section1256TermGL * 0.60)
        let shortTermGLIncluding1256 = shortTermGL + (section1256TermGL * 0.40)
        
        if(longTermGLIncluding1256 >= 0 && shortTermGLIncluding1256 >= 0)
        {
            filingStatus.TaxOnLTCapitalGain = GetCapitalGainTax(longTermGLIncluding1256, termTaxDictionary: longTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome, lstFilingStatusTaxAt: &filingStatus.FilingStatusTax)
            filingStatus.TaxOnSTCapitalGain = GetCapitalGainTax(shortTermGLIncluding1256, termTaxDictionary: shortTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome, lstFilingStatusTaxAt: &filingStatus.FilingStatusTax)
            
            filingStatus.NetLoss = 0
            
        }
        else if(longTermGLIncluding1256 < 0 && shortTermGLIncluding1256 >= 0)
        {
            if(longTermGLIncluding1256 + shortTermGLIncluding1256 > 0)
            {
                filingStatus.TaxOnSTCapitalGain = GetCapitalGainTax(longTermGLIncluding1256 + shortTermGLIncluding1256, termTaxDictionary: shortTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome, lstFilingStatusTaxAt: &filingStatus.FilingStatusTax)
                
                filingStatus.NetLoss = 0
            }
            else
            {
                filingStatus.NetLoss = longTermGLIncluding1256 + shortTermGLIncluding1256
            }
        }
        else if(longTermGLIncluding1256 >= 0 && shortTermGLIncluding1256 < 0)
        {
            if(longTermGLIncluding1256 + shortTermGLIncluding1256 > 0)
            {
                filingStatus.TaxOnLTCapitalGain = GetCapitalGainTax(longTermGLIncluding1256 + shortTermGLIncluding1256, termTaxDictionary: longTermTax!, taxableIncome: filingStatus.CurrentTaxableIncome, lstFilingStatusTaxAt: &filingStatus.FilingStatusTax)
                
                filingStatus.NetLoss = 0
            }
            else
            {
                filingStatus.NetLoss = longTermGLIncluding1256 + shortTermGLIncluding1256
            }
        }
        else if(longTermGLIncluding1256 < 0 && shortTermGLIncluding1256 < 0)
        {
            filingStatus.NetLoss = longTermGLIncluding1256 + shortTermGLIncluding1256
        }
        
        filingStatus.TaxOnLTSTCapitalGain = filingStatus.TaxOnLTCapitalGain + filingStatus.TaxOnSTCapitalGain
        
        return filingStatus
    }
    
    func GetCapitalGainTax(var termGL: Double, termTaxDictionary : TaxBracket, var taxableIncome : Double, inout  lstFilingStatusTaxAt: [FilingStatusTaxAt] ) -> Double
    {
        var totalIncomeIncludingCapitalGain : Double
        var taxOnCapitalGain : Double = 0
        
        let cntTaxDictionary = termTaxDictionary.FederalTax.count
        let maxTaxValue = termTaxDictionary.FederalTax.array[cntTaxDictionary - 1]
        let maxTaxItem = termTaxDictionary.FederalTax.dictionary[maxTaxValue]
        
        totalIncomeIncludingCapitalGain = taxableIncome + termGL
      
        
        for item in termTaxDictionary.FederalTax.array
        {
            if(item >= taxableIncome)
            {
                let x = totalIncomeIncludingCapitalGain - item
                
                let hairCutPerc =  termTaxDictionary.FederalTax.dictionary[item]!
                    
                if(x < 0)
                {
                    
                    taxOnCapitalGain = taxOnCapitalGain + (termGL * hairCutPerc)

                    let filingStatusTaxAt = FilingStatusTaxAt()
                    filingStatusTaxAt.Term = termTaxDictionary.Term
                    filingStatusTaxAt.Limit = termGL
                    filingStatusTaxAt.LimitTaxedAt = hairCutPerc
                    lstFilingStatusTaxAt.append(filingStatusTaxAt)

                    break;
                }
                
                else
                {
                    
                    taxOnCapitalGain = (item - taxableIncome) * hairCutPerc
 
                    let filingStatusTaxAt = FilingStatusTaxAt()
                    filingStatusTaxAt.Term = termTaxDictionary.Term
                    filingStatusTaxAt.Limit = item - taxableIncome
                    filingStatusTaxAt.LimitTaxedAt = hairCutPerc
                    lstFilingStatusTaxAt.append(filingStatusTaxAt)
                    
                    termGL = x
                    taxableIncome = totalIncomeIncludingCapitalGain

                    continue
                }
            }
            
            else if (item == maxTaxValue)
            {
                taxOnCapitalGain = taxOnCapitalGain + (termGL * maxTaxItem!)
              
                let filingStatusTaxAt = FilingStatusTaxAt()
                filingStatusTaxAt.Term = termTaxDictionary.Term //ToDO - test
                filingStatusTaxAt.Limit = termGL
                filingStatusTaxAt.LimitTaxedAt = maxTaxItem!
                lstFilingStatusTaxAt.append(filingStatusTaxAt)
            }
        }
        
        return taxOnCapitalGain
    }
}