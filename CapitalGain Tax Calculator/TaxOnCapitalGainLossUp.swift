//
//  TaxOnCapitalGainLossUp.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/1/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

struct TaxOnCapitalGainLossUp {
    
    init()
    {
       // LoadFederalTax()
        
    }
    static var _taxBracketList: [TaxBracket] = [TaxBracket]()
    
    
    static func LoadFederalTax()
    {
        //Single 2015
        
        var br_LT_Single_2015 = TaxBracket()
        
        br_LT_Single_2015.FilingType = ENumFilingType.Single
        br_LT_Single_2015.Year = 2015
        br_LT_Single_2015.Term = ENumTerm.LongTerm
       
         br_LT_Single_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
         br_LT_Single_2015.FederalTax.insert(0, forKey: 9225, atIndex: 1)
         br_LT_Single_2015.FederalTax.insert(0, forKey: 37450, atIndex: 2)
         br_LT_Single_2015.FederalTax.insert(0, forKey: 90750, atIndex: 3)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 189399, atIndex: 4)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 411500, atIndex: 5)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 413200, atIndex: 6)
         br_LT_Single_2015.FederalTax.insert(0.20, forKey: 413201, atIndex: 7)
        
         _taxBracketList.append(br_LT_Single_2015)
        
        
        var br_ST_Single_2015 = TaxBracket()
        
        br_ST_Single_2015.FilingType = ENumFilingType.Single
        br_ST_Single_2015.Year = 2015
        br_ST_Single_2015.Term = ENumTerm.ShortTerm
        
        br_ST_Single_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_ST_Single_2015.FederalTax.insert(0.10, forKey: 9225, atIndex: 1)
        br_ST_Single_2015.FederalTax.insert(0.15, forKey: 37450, atIndex: 2)
        br_ST_Single_2015.FederalTax.insert(0.25, forKey: 90750, atIndex: 3)
        br_ST_Single_2015.FederalTax.insert(0.28, forKey: 189300, atIndex: 4)
        br_ST_Single_2015.FederalTax.insert(0.33, forKey: 411500, atIndex: 5)
        br_ST_Single_2015.FederalTax.insert(0.35, forKey: 413200, atIndex: 6)
        br_ST_Single_2015.FederalTax.insert(0.396, forKey: 413201, atIndex: 7)

        
        
        _taxBracketList.append(br_ST_Single_2015)
        
        
        //Joint 2015
        
    /*    var br_LT_Joint_2015 = TaxBracket()
        
        br_LT_Joint_2015.FilingType = ENumFilingType.Joint
        br_LT_Joint_2015.Year = 2015
        br_LT_Joint_2015.Term = ENumTerm.LongTerm
        
        br_LT_Joint_2015.FederalTax = [0:0]
        br_LT_Joint_2015.FederalTax = [18450:0]
        br_LT_Joint_2015.FederalTax = [74900:0.15]
        br_LT_Joint_2015.FederalTax = [151200:0.15]
        br_LT_Joint_2015.FederalTax = [230450:0.15]
        br_LT_Joint_2015.FederalTax = [411500:0.15]
        br_LT_Joint_2015.FederalTax = [464850:0.15]
        br_LT_Joint_2015.FederalTax = [464851:0.20]
        
        _taxBracketList.append(br_LT_Joint_2015)
        
      
        var br_ST_Joint_2015 = TaxBracket()
        
        br_ST_Joint_2015.FilingType = ENumFilingType.Joint
        br_ST_Joint_2015.Year = 2015
        br_ST_Joint_2015.Term = ENumTerm.ShortTerm
        
        br_ST_Joint_2015.FederalTax = [0:0]
        br_ST_Joint_2015.FederalTax = [18450:0.10]
        br_ST_Joint_2015.FederalTax = [74900:0.15]
        br_ST_Joint_2015.FederalTax = [151200:0.25]
        br_ST_Joint_2015.FederalTax = [230450:0.28]
        br_ST_Joint_2015.FederalTax = [411500:0.33]
        br_ST_Joint_2015.FederalTax = [464850:0.35]
        br_ST_Joint_2015.FederalTax = [464851:0.396]
        
        _taxBracketList.append(br_ST_Joint_2015)
        
        //HOH 2015
        
        var br_LT_HOH_2015 = TaxBracket()
        
        br_LT_HOH_2015.FilingType = ENumFilingType.HoH
        br_LT_HOH_2015.Year = 2015
        br_LT_HOH_2015.Term = ENumTerm.LongTerm
        
        br_LT_HOH_2015.FederalTax = [0:0]
        br_LT_HOH_2015.FederalTax = [13150:0]
        br_LT_HOH_2015.FederalTax = [50200:0]
        br_LT_HOH_2015.FederalTax = [129600:0.15]
        br_LT_HOH_2015.FederalTax = [209850:0.15]
        br_LT_HOH_2015.FederalTax = [411500:0.15]
        br_LT_HOH_2015.FederalTax = [439000:0.15]
        br_LT_HOH_2015.FederalTax = [439001:0.20]
        
        _taxBracketList.append(br_LT_HOH_2015)
        
        
        var br_ST_HOH_2015 = TaxBracket()
        
        br_ST_HOH_2015.FilingType = ENumFilingType.HoH
        br_ST_HOH_2015.Year = 2015
        br_ST_HOH_2015.Term = ENumTerm.ShortTerm
        
        br_ST_HOH_2015.FederalTax = [0:0]
        br_ST_HOH_2015.FederalTax = [13150:0.10]
        br_ST_HOH_2015.FederalTax = [50200:0.15]
        br_ST_HOH_2015.FederalTax = [129600:0.25]
        br_ST_HOH_2015.FederalTax = [209850:0.28]
        br_ST_HOH_2015.FederalTax = [411500:0.33]
        br_ST_HOH_2015.FederalTax = [439000:0.35]
        br_ST_HOH_2015.FederalTax = [439001:0.396]
        
        _taxBracketList.append(br_ST_HOH_2015)
        
        //Separate 2015
        
        var br_LT_Separate_2015 = TaxBracket()
        
        br_LT_Separate_2015.FilingType = ENumFilingType.Separate
        br_LT_Separate_2015.Year = 2015
        br_LT_Separate_2015.Term = ENumTerm.LongTerm
        
        br_LT_Separate_2015.FederalTax = [0:0]
        br_LT_Separate_2015.FederalTax = [9225:0]
        br_LT_Separate_2015.FederalTax = [37450:0]
        br_LT_Separate_2015.FederalTax = [75600:0.15]
        br_LT_Separate_2015.FederalTax = [115225:0.15]
        br_LT_Separate_2015.FederalTax = [205750:0.15]
        br_LT_Separate_2015.FederalTax = [232425:0.15]
        br_LT_Separate_2015.FederalTax = [232426:0.20]
        
        _taxBracketList.append(br_LT_Separate_2015)
        
        var br_ST_Separate_2015 = TaxBracket()
        
        br_ST_Separate_2015.FilingType = ENumFilingType.Separate
        br_ST_Separate_2015.Year = 2015
        br_ST_Separate_2015.Term = ENumTerm.ShortTerm
        
        br_ST_Separate_2015.FederalTax = [0:0]
        br_ST_Separate_2015.FederalTax = [9225:0.10]
        br_ST_Separate_2015.FederalTax = [37450:0.15]
        br_ST_Separate_2015.FederalTax = [75600:0.25]
        br_ST_Separate_2015.FederalTax = [115225:0.28]
        br_ST_Separate_2015.FederalTax = [205750:0.33]
        br_ST_Separate_2015.FederalTax = [232425:0.35]
        br_ST_Separate_2015.FederalTax = [232426:0.396]
        
        _taxBracketList.append(br_ST_Separate_2015)
*/

    }
    
    static func GetTaxHairCut(filingStatus: FilingStatus) -> [TaxBracket]
    {
         let taxBracketArray = _taxBracketList.filter({m in m.Year == filingStatus.Year && m.FilingType.rawValue == filingStatus.FilingType.rawValue})
        
        let lstTaxBracket = taxBracketArray as [TaxBracket]
        
     //   let taxBracket = lstTaxBracket.first
        return lstTaxBracket
    }
    
    
    
   
}
