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
    func GetLotsByTerm(lstLotPosition: NSMutableArray)-> NSMutableArray
    {
        var lstLotTerm = NSMutableArray()
        lstLotTerm = CapitalGainController.sharedDBInstance.ReturnLotTerm()
        
        return lstLotTerm
    }
    
    func GetTaxableIncome(lstFilingStatus: NSMutableArray, lstLotPosition: NSMutableArray)
    {
        
    }
    
   // func GetCapitalGainTax(termGL Float, T
}