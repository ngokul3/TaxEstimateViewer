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
    
    func DeleteFilingStatusItem(index: Int)
    {
        lstFilingStatus.removeAtIndex(index) //ToDO - Defensive Coding required
    }
    

}
