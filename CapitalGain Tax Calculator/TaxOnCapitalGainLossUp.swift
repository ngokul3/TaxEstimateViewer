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
        
        let br_LT_Single_2015 = TaxBracket()
        
        br_LT_Single_2015.FilingType = ENumFilingType.Single
        br_LT_Single_2015.Year = 2015
        br_LT_Single_2015.Term = ENumTerm.LongTerm
       
         br_LT_Single_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
         br_LT_Single_2015.FederalTax.insert(0, forKey: 9225, atIndex: 1)
         br_LT_Single_2015.FederalTax.insert(0, forKey: 37450, atIndex: 2)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 90750, atIndex: 3)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 189300, atIndex: 4)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 411500, atIndex: 5)
         br_LT_Single_2015.FederalTax.insert(0.15, forKey: 413200, atIndex: 6)
         br_LT_Single_2015.FederalTax.insert(0.20, forKey: 413201, atIndex: 7)
        
         _taxBracketList.append(br_LT_Single_2015)
        
        
        let br_ST_Single_2015 = TaxBracket()
        
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
        
        let br_LT_Joint_2015 = TaxBracket()
        
        br_LT_Joint_2015.FilingType = ENumFilingType.Joint
        br_LT_Joint_2015.Year = 2015
        br_LT_Joint_2015.Term = ENumTerm.LongTerm
        
        br_LT_Joint_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_LT_Joint_2015.FederalTax.insert(0, forKey: 18450, atIndex: 1)
        br_LT_Joint_2015.FederalTax.insert(0.15, forKey: 74900, atIndex: 2)
        br_LT_Joint_2015.FederalTax.insert(0.15, forKey: 151200, atIndex: 3)
        br_LT_Joint_2015.FederalTax.insert(0.15, forKey: 230450, atIndex: 4)
        br_LT_Joint_2015.FederalTax.insert(0.15, forKey: 411500, atIndex: 5)
        br_LT_Joint_2015.FederalTax.insert(0.15, forKey: 464850, atIndex: 6)
        br_LT_Joint_2015.FederalTax.insert(0.20, forKey: 464851, atIndex: 7)
        
        _taxBracketList.append(br_LT_Joint_2015)
        
      
        let br_ST_Joint_2015 = TaxBracket()
        
        br_ST_Joint_2015.FilingType = ENumFilingType.Joint
        br_ST_Joint_2015.Year = 2015
        br_ST_Joint_2015.Term = ENumTerm.ShortTerm
 
        br_ST_Joint_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_ST_Joint_2015.FederalTax.insert(0.10, forKey: 18450, atIndex: 1)
        br_ST_Joint_2015.FederalTax.insert(0.15, forKey: 74900, atIndex: 2)
        br_ST_Joint_2015.FederalTax.insert(0.25, forKey: 151200, atIndex: 3)
        br_ST_Joint_2015.FederalTax.insert(0.28, forKey: 230450, atIndex: 4)
        br_ST_Joint_2015.FederalTax.insert(0.33, forKey: 411500, atIndex: 5)
        br_ST_Joint_2015.FederalTax.insert(0.35, forKey: 464850, atIndex: 6)
        br_ST_Joint_2015.FederalTax.insert(0.396, forKey: 464851, atIndex: 7)
        
        
        _taxBracketList.append(br_ST_Joint_2015)
        
        //HOH 2015
        
        let br_LT_HOH_2015 = TaxBracket()
        
        br_LT_HOH_2015.FilingType = ENumFilingType.HoH
        br_LT_HOH_2015.Year = 2015
        br_LT_HOH_2015.Term = ENumTerm.LongTerm
        
        br_LT_HOH_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_LT_HOH_2015.FederalTax.insert(0, forKey: 13150, atIndex: 1)
        br_LT_HOH_2015.FederalTax.insert(0, forKey: 50200, atIndex: 2)
        br_LT_HOH_2015.FederalTax.insert(0.15, forKey: 129600, atIndex: 3)
        br_LT_HOH_2015.FederalTax.insert(0.15, forKey: 209850, atIndex: 4)
        br_LT_HOH_2015.FederalTax.insert(0.15, forKey: 411500, atIndex: 5)
        br_LT_HOH_2015.FederalTax.insert(0.15, forKey: 439000, atIndex: 6)
        br_LT_HOH_2015.FederalTax.insert(0.20, forKey: 439001, atIndex: 7)

        
        _taxBracketList.append(br_LT_HOH_2015)
        
        
        let br_ST_HOH_2015 = TaxBracket()
        
        br_ST_HOH_2015.FilingType = ENumFilingType.HoH
        br_ST_HOH_2015.Year = 2015
        br_ST_HOH_2015.Term = ENumTerm.ShortTerm
      
        br_ST_HOH_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_ST_HOH_2015.FederalTax.insert(0.10, forKey: 13150, atIndex: 1)
        br_ST_HOH_2015.FederalTax.insert(0.15, forKey: 50200, atIndex: 2)
        br_ST_HOH_2015.FederalTax.insert(0.25, forKey: 129600, atIndex: 3)
        br_ST_HOH_2015.FederalTax.insert(0.28, forKey: 209850, atIndex: 4)
        br_ST_HOH_2015.FederalTax.insert(0.33, forKey: 411500, atIndex: 5)
        br_ST_HOH_2015.FederalTax.insert(0.35, forKey: 439000, atIndex: 6)
        br_ST_HOH_2015.FederalTax.insert(0.396, forKey: 439001, atIndex: 7)

        
        _taxBracketList.append(br_ST_HOH_2015)
        
        //Separate 2015
        
        let br_LT_Separate_2015 = TaxBracket()
        
        br_LT_Separate_2015.FilingType = ENumFilingType.Separate
        br_LT_Separate_2015.Year = 2015
        br_LT_Separate_2015.Term = ENumTerm.LongTerm
        
        br_LT_Separate_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_LT_Separate_2015.FederalTax.insert(0, forKey: 9225, atIndex: 1)
        br_LT_Separate_2015.FederalTax.insert(0, forKey: 37450, atIndex: 2)
        br_LT_Separate_2015.FederalTax.insert(0.15, forKey: 75600, atIndex: 3)
        br_LT_Separate_2015.FederalTax.insert(0.15, forKey: 115225, atIndex: 4)
        br_LT_Separate_2015.FederalTax.insert(0.15, forKey: 205750, atIndex: 5)
        br_LT_Separate_2015.FederalTax.insert(0.15, forKey: 232425, atIndex: 6)
        br_LT_Separate_2015.FederalTax.insert(0.20, forKey: 232426, atIndex: 7)

        
        _taxBracketList.append(br_LT_Separate_2015)
        
        let br_ST_Separate_2015 = TaxBracket()
        
        br_ST_Separate_2015.FilingType = ENumFilingType.Separate
        br_ST_Separate_2015.Year = 2015
        br_ST_Separate_2015.Term = ENumTerm.ShortTerm
        
        br_ST_Separate_2015.FederalTax.insert(0, forKey: 0, atIndex: 0)
        br_ST_Separate_2015.FederalTax.insert(0.10, forKey: 9225, atIndex: 1)
        br_ST_Separate_2015.FederalTax.insert(0.15, forKey: 37450, atIndex: 2)
        br_ST_Separate_2015.FederalTax.insert(0.25, forKey: 75600, atIndex: 3)
        br_ST_Separate_2015.FederalTax.insert(0.28, forKey: 115225, atIndex: 4)
        br_ST_Separate_2015.FederalTax.insert(0.33, forKey: 205750, atIndex: 5)
        br_ST_Separate_2015.FederalTax.insert(0.35, forKey: 232425, atIndex: 6)
        br_ST_Separate_2015.FederalTax.insert(0.396, forKey: 232426, atIndex: 7)

          
        _taxBracketList.append(br_ST_Separate_2015)


    }
    
    static func GetTaxHairCut(filingStatus: FilingStatus) -> [TaxBracket]
    {
        var lstTaxBracket = [TaxBracket]()
        
        
       // let taxBracketArray = _taxBracketList.filter({m in m.Year == filingStatus.Year && m.FilingType.rawValue == filingStatus.FilingType.rawValue})
        
        let maxYear = _taxBracketList.map{ return $0.Year }.reduce(Int.min, combine: {max($0, $1)} )
        
        lstTaxBracket = _taxBracketList.filter({m in m.Year == filingStatus.Year && m.FilingType.rawValue == filingStatus.FilingType.rawValue}) as [TaxBracket]
        
        if (lstTaxBracket.count == 0 )
        {
            lstTaxBracket = _taxBracketList.filter({m in m.Year == maxYear && m.FilingType.rawValue == filingStatus.FilingType.rawValue}) as [TaxBracket]
            
        }
     //    .reduce(0) { (total, number) in max(total, number) }
     //   let lstTaxBracket = taxBracketArray as [TaxBracket]
        
        return lstTaxBracket
    }
    
    
    
   
}
