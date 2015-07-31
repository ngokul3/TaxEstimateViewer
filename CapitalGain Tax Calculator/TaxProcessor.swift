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
        let lstLotTerm = NSMutableArray()
        
        for lotPosition: AnyObject in lstLotPosition
        {
            
            if let user: AnyObject = lotPosition.valueForKey("username") {
                
                println(user)
                
            }

            
        }
        return lstLotTerm
    }
}