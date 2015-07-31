//
//  CapitalGainManager.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/21/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation


class CapitalGainControllerManager{
    var investmentArray =  NSMutableArray()
    var filingStatusArray = NSMutableArray()
    
    init()
    {
        let investmentArray = NSMutableArray()
        let filingStatusArray = NSMutableArray()
    }
    
    
    func AddInvestment(lotPosition: LotPosition)->NSMutableArray
    {
        investmentArray.addObject(lotPosition)
        return investmentArray
    }
    func GetInvestments()->NSMutableArray
    {
        return investmentArray
    }
    
    func DeleteInvestments(lotPosition: LotPosition)->NSMutableArray
    {
        let investDict = NSMutableArray()
        
        return investDict
    }
    
    func EditInvestment()->NSMutableArray
    {
        let investDict = NSMutableArray()
        
        return investDict
    }
    
    func GetPositionItem(index: Int)-> LotPosition
    {
        let lotPosition: LotPosition = investmentArray.objectAtIndex(index) as! LotPosition
        return lotPosition

    }
    
    func AddFilingStatus(filingStatus: FilingStatus)->NSMutableArray
    {
        filingStatusArray.addObject(filingStatus)
        return filingStatusArray
        
    }
    func GetFilingStatus()->NSMutableArray
    {
        return filingStatusArray
    }
    
    func GetFilingStatusItem(index: Int)-> FilingStatus
    {
        let filingStatus: FilingStatus = filingStatusArray.objectAtIndex(index) as! FilingStatus
        return filingStatus
        
    }
    
    

}
