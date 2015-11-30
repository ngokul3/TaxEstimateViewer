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
    private var _resultFilingStatus : FilingStatus
    
    init()
    {
       _resultFilingStatus = FilingStatus()
        
    }
    
    func SetResultFilingStatus(filingStatus : FilingStatus )
    {
        _resultFilingStatus = filingStatus
    
    }
    
    func GetResultFilingStatus() -> FilingStatus
    {
        return _resultFilingStatus
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
            var lstLotPositionForYear = lstLotPosition.filter({m in m.RealizedYear == year})
            
            lstLotPositionForYear = lstLotPositionForYear.sort{ (element1, element2) -> Bool in
                return element1.SymbolCode.lowercaseString < element2.SymbolCode.lowercaseString
            }
            return lstLotPositionForYear
        }
        else
        {
            return [LotPosition]()
        }
        
    }
    func UpdateLotPosition(lotPosition: LotPosition)
    {
        let selectedLotPosition = lstLotPosition.filter({m in m.LotId == lotPosition.LotId}).first
        
        selectedLotPosition?.SymbolCode = lotPosition.SymbolCode
        selectedLotPosition?.Direction = lotPosition.Direction
        selectedLotPosition?.RealizedGainLoss = lotPosition.RealizedGainLoss
        selectedLotPosition?.RealizedYear = lotPosition.RealizedYear
        selectedLotPosition?.IsLongTerm = lotPosition.IsLongTerm
    }
    
    
    func DeleteLotPositionItem(lotPosition: LotPosition)
    {
        
       if let foundIndex = self.lstLotPosition.indexOf(lotPosition)
       {
        self.lstLotPosition.removeAtIndex(foundIndex)

        }
    }
  
  
    func AddFilingStatus(filingStatus: FilingStatus)->[FilingStatus]
    {
        lstFilingStatus.append(filingStatus)
        
        lstFilingStatus = lstFilingStatus.sort{ (element1, element2) -> Bool in
            return element1.Year > element2.Year
        }

        return lstFilingStatus
        
    }
    func GetFilingStatus()->[FilingStatus]
    {
        let sortedLstFilingStatus = lstFilingStatus.sort{ (element1, element2) -> Bool in
            return element1.Year > element2.Year
        }
        return sortedLstFilingStatus
    }
    
    func GetFilingStatusItem(index: Int)-> FilingStatus
    {
        let filingStatus: FilingStatus = lstFilingStatus[index]
        return filingStatus
        
    }
    
    func GetFilingStatusForYear(year: Int)-> FilingStatus?
    {
        if(lstFilingStatus.filter({m in m.Year == year}).count > 0 )
        {
            let filingStatus = lstFilingStatus.filter({m in m.Year == year}).first
            
            return filingStatus!
        }
        else
        {
            return nil
        }
        
    }
    func UpdateFilingStatus(filingStatus: FilingStatus)
    {
        let selectedFilingStatus = lstFilingStatus.filter({m in m.FilingStatusId == filingStatus.FilingStatusId}).first
        
        selectedFilingStatus?.Year = filingStatus.Year
        selectedFilingStatus?.FilingType = filingStatus.FilingType
        selectedFilingStatus?.CurrentTaxableIncome = filingStatus.CurrentTaxableIncome
        
    }
    
  
    func DeleteFilingStatusItem(index: Int)
    {
        if lstFilingStatus.count > index
        {
            lstFilingStatus.removeAtIndex(index)
            
        }
        
       
    }
    

}

extension Array {
    /*mutating func removeObject<T: Equatable>(object: T) {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self) {
            let to = objectToCompare as! T
            if object == to {
                index = idx
            }
        }
        
        if((index) != nil) {
            self.removeAtIndex(index!)
        }
    }*/ //ToDo Convert
}