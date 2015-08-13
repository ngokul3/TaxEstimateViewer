//
//  CapitalGainManager.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/21/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation


class CapitalGainControllerManager{
    var lstLotPosition = [LotPosition]()
    var lstFilingStatus = [FilingStatus]()
    
    init()
    {
       
    }
    
    
    func AddLotPosition(lotPosition: LotPosition)
    {
        lstLotPosition.append(lotPosition)
        
    }
    
    func GetLotPositions() ->[LotPosition]
    {
        return lstLotPosition
        
    }
    
    
    func GetLotPositionItem(index: Int)-> LotPosition
    {
        let lotPosition: LotPosition = lstLotPosition[index]
        return lotPosition
        
    }
    
    func GetLotPositionForYear(year: Int)-> [LotPosition]
    {
        if(lstLotPosition.filter({m in m.RealizedYear == year}).count > 0)
        {
            let lstLotPositionForYear = lstLotPosition.filter({m in m.RealizedYear == year})
            return lstLotPositionForYear
        }
        else
        {
            return [LotPosition]()
        }
        
    }
    func UpdateLotPosition(lotPosition: LotPosition)
    {
       // var selectedLotPosition : LotPosition
        let selectedLotPosition = lstLotPosition.filter({m in m.LotId == lotPosition.LotId}).first
        
        selectedLotPosition?.SymbolCode = lotPosition.SymbolCode
        selectedLotPosition?.Direction = lotPosition.Direction
        selectedLotPosition?.InvestmentType = lotPosition.InvestmentType
        selectedLotPosition?.RealizedGainLoss = lotPosition.RealizedGainLoss
        selectedLotPosition?.RealizedYear = lotPosition.RealizedYear
        selectedLotPosition?.IsLongTerm = lotPosition.IsLongTerm
    }
    
    
    func DeleteLotPositionItem(index: Int)
    {
        
        lstLotPosition.removeAtIndex(index) //ToDO - Defensive Coding required
    }
  
  
    func AddFilingStatus(filingStatus: FilingStatus)->[FilingStatus]
    {
        lstFilingStatus.append(filingStatus)
        return lstFilingStatus
        
    }
    func GetFilingStatus()->[FilingStatus]
    {
        return lstFilingStatus
    }
    
    func GetFilingStatusItem(index: Int)-> FilingStatus
    {
        let filingStatus: FilingStatus = lstFilingStatus[index]
        return filingStatus
        
    }
    
    func GetFilingStatusForYear(year: Int)-> FilingStatus
    {
        if(lstFilingStatus.filter({m in m.Year == year}).count > 0 )
        {
            let filingStatus = lstFilingStatus.filter({m in m.Year == year}).first
            return filingStatus!
        }
        else
        {
            return FilingStatus()
        }
        
    }
    func UpdateFilingStatus(filingStatus: FilingStatus)
    {
        let selectedFilingStatus = lstFilingStatus.filter({m in m.FilingStatusId == filingStatus.FilingStatusId}).first
        
        selectedFilingStatus?.Year = filingStatus.Year
        selectedFilingStatus?.FilingType = filingStatus.FilingType
        selectedFilingStatus?.CurrentTaxableIncome = filingStatus.CurrentTaxableIncome
        selectedFilingStatus?.PreviouslyDeferredLoss = filingStatus.PreviouslyDeferredLoss
    }
    
    func DeleteFilingStatusItem(index: Int)
    {
        lstFilingStatus.removeAtIndex(index) //ToDO - Defensive Coding required
    }
    

}
