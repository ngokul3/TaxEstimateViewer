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
    
    init()
    {
        let investmentArray = NSMutableArray()
        
    }
    
    
    func AddInvestment(lotPosition: LotPosition)->NSMutableArray
    {
        investmentArray.addObject(LotPosition)
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
}
