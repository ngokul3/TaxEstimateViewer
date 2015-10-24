//
//  Utils.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 9/13/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

public class Utils
{
    func ConvertStringToCurrency(strPrice : String!) -> String!
    {
        
var formatter = NSNumberFormatter()
        
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 0
        
        if(strPrice.toDouble() != nil)
        {
            let profitLoss = formatter.stringFromNumber(strPrice.toDouble()!)
            
            return profitLoss
        }
        else
        {
            return strPrice
        }
        
    }
    
    func ConvertCurrencyToString(strCurrency : String!) -> String!
    {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        let profitLoss = formatter.numberFromString(strCurrency!)
        
        if(profitLoss != nil)
        {
            return profitLoss?.description
            
        }
        else
        {
           return strCurrency
        }

    }
}