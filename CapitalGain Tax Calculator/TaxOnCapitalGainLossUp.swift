//
//  TaxOnCapitalGainLossUp.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/1/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

 struct TaxOnCapitalGainLossUp{
    
    static var _taxBracketList: [TaxBracket] = [TaxBracket]()
    
    
    static func LoadFederalTax()
    {
        var br_LT_Single_2015 = TaxBracket()
         br_LT_Single_2015.FilingType = ENumFilingType.Single
        br_LT_Single_2015.FederalTax = [1:2]
        br_LT_Single_2015.FederalTax = [3:5]
        
        
      //  br_LT_Single_2015.FederalTax.setValue(x, "dd")
        //_taxBracketList.
        
        var obj = NSMutableDictionary()
        
        var myDictionary = Dictionary<Int, Int>()
        
    }
}