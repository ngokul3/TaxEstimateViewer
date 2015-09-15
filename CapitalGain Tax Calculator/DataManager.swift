//
//  DataManager.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/31/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

class DataManager
{
    var _databasePath: NSString
    var _filemgr: NSFileManager
    var _dirPaths: AnyObject
    var _docsDir: NSString
    var _capitalGainCalculatorDB: FMDatabase!
    
    init()
    {
        self._dirPaths =   NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        self._docsDir = _dirPaths[0] as! String
       self._databasePath = _docsDir.stringByAppendingPathComponent( "Test1")
         self._filemgr = NSFileManager.defaultManager()
        self._capitalGainCalculatorDB = FMDatabase()
    }
    
    func OpenDatabase()->Bool
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        return self._capitalGainCalculatorDB.open()
    }
    func CreateTable(){
      //  if !self._filemgr.fileExistsAtPath(_databasePath as String) {
        
            if !self._capitalGainCalculatorDB.open()
            {
                self._capitalGainCalculatorDB.open()
            }
            self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
            
            if self._capitalGainCalculatorDB == nil {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
            if self._capitalGainCalculatorDB.open() {
                let lotPositionTable = "CREATE TABLE IF NOT EXISTS LotPosition (LotPositionID INTEGER PRIMARY KEY AUTOINCREMENT, SymbolCode TEXT, InvestmentType TEXT, Direction TEXT, RealizedGainLoss DOUBLE, Year INTEGER, IsLongTerm BOOLEAN)"
                if !self._capitalGainCalculatorDB.executeStatements(lotPositionTable) {
                    println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
                
                let filingStatusTable = "CREATE TABLE IF NOT EXISTS FilingStatus (FilingStatusID INTEGER PRIMARY KEY AUTOINCREMENT, FilingType TEXT, Year INTEGER, CurrentTaxableIncome DOUBLE, PreviouslyDeferredLoss DOUBLE)"
                if !self._capitalGainCalculatorDB.executeStatements(filingStatusTable) {
                    println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
                
                self._capitalGainCalculatorDB.close()
            } else {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
       // }
    }
    
    func InsertInvestment(lotPosition: LotPosition) -> NSString
    {
        //TODO: Check for already existing lots
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
      //  for index in 0...cntPositions-1 {
        if self._capitalGainCalculatorDB.open()
        {
               // let lotPosition = CapitalGainController.sharedInstance.GetPositionItem(index)
            
                let isLongTerm = lotPosition.IsLongTerm ? 1 : 0
                let investmentType = lotPosition.InvestmentType.associatedValue(lotPosition.InvestmentType)
            
                let insertSQL = "INSERT INTO LotPosition (SymbolCode, InvestmentType, Direction, RealizedGainLoss, Year, IsLongTerm) VALUES ('\(lotPosition.SymbolCode)', '\(lotPosition.InvestmentType.rawValue)', '\(lotPosition.Direction.rawValue)', \(lotPosition.RealizedGainLoss), \(lotPosition.RealizedYear), \(isLongTerm))" //TODO
            
                NSLog(insertSQL)
                let result = self._capitalGainCalculatorDB.executeUpdate(insertSQL,
                    withArgumentsInArray: nil)
                
                if !result {
                    println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
            } else {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                return "Error" //ToDO
            }
    
        return ""//ToDO
    }
    
    func InsertFilingStatus(filingStatus: FilingStatus) -> NSString
    {
        //TODO: Check for already existing record
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        if self._capitalGainCalculatorDB.open()
        {
            
            
            let insertSQL = "INSERT INTO FilingStatus (Year, FilingType, CurrentTaxableIncome, PreviouslyDeferredLoss) VALUES ('\(filingStatus.Year)', '\(filingStatus.FilingType.rawValue)', \(filingStatus.CurrentTaxableIncome), \(filingStatus.PreviouslyDeferredLoss))"
            
            let result = self._capitalGainCalculatorDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
        } else {
            println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            return "Error" //ToDO
        }
        
        return ""//ToDO
    }

    func UpdateInvestment(lotPosition: LotPosition) -> NSString
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        if self._capitalGainCalculatorDB.open()
        {
            let isLongTerm = lotPosition.IsLongTerm ? 1 : 0
            
            
            let updateSQL = "Update LotPosition set SymbolCode = '\(lotPosition.SymbolCode)', InvestmentType = '\(lotPosition.InvestmentType.rawValue)', Direction = '\(lotPosition.Direction.rawValue)', RealizedGainLoss = \(lotPosition.RealizedGainLoss), Year = \(lotPosition.RealizedYear), IsLongTerm = \(isLongTerm) Where LotPositionId = \(lotPosition.LotId)" //TODO
            
            let result = self._capitalGainCalculatorDB.executeUpdate(updateSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
        } else {
            println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            return "Error" //ToDO
        }
        
        return ""//ToDO
    }
    
    func UpdateFilingStatus(filingStatus: FilingStatus) -> NSString
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        if self._capitalGainCalculatorDB.open()
        {
            
            let updateSQL = "Update FilingStatus set Year = \(filingStatus.Year), FilingType = '\(filingStatus.FilingType.rawValue)', CurrentTaxableIncome = \(filingStatus.CurrentTaxableIncome), PreviouslyDeferredLoss = \(filingStatus.PreviouslyDeferredLoss) Where FilingStatusId = \(filingStatus.FilingStatusId)"
            
            let result = self._capitalGainCalculatorDB.executeUpdate(updateSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
        } else {
            println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            return "Error" //ToDO
        }
        
        return ""//ToDO
    }

    func DeleteLotPosition(lotPosition: LotPosition) -> Bool?
    {
        if self._capitalGainCalculatorDB.open()
        {

        let deleteLotPositionSql = "Delete From LotPosition Where LotPositionID =  \(lotPosition.LotId) "
       
        NSLog(deleteLotPositionSql)
        
        
        let results:Bool? = self._capitalGainCalculatorDB.executeUpdate (deleteLotPositionSql,
            withArgumentsInArray: nil)
        
        if !(results != nil) {
            println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            
        }
       
        return results
        }
        
        return false
    }
    
    func DeleteFilingStatus(filingStatus: FilingStatus) -> Bool?
    {
        if self._capitalGainCalculatorDB.open()
        {
            
            let deleteFilingStatusSql = "Delete From FilingStatus Where FilingStatusID =  \(filingStatus.FilingStatusId) "
            
            NSLog(deleteFilingStatusSql)
            
            
            let results:Bool? = self._capitalGainCalculatorDB.executeUpdate (deleteFilingStatusSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                
            }
            
            return results
        }
        
        return false
    }
    func ReturnLotPosition() -> [LotPosition]
    {
        if self._capitalGainCalculatorDB.open()
        {
            var lstLotPosition : [LotPosition] = [LotPosition]()
            
            let selectLotPositionSql = "Select LotPositionID, SymbolCode, InvestmentType, Direction, RealizedGainLoss, Year, IsLongTerm From LotPosition Order By SymbolCode"
            
            NSLog(selectLotPositionSql)
            
            
            let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectLotPositionSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }

            while results?.next() == true {
                
                let lotPosition = LotPosition()
                
                lotPosition.LotId = results?.intForColumn("LotPositionID") as Int32!
                
                NSLog(lotPosition.LotId.description)
                
                lotPosition.SymbolCode = (results?.stringForColumn("SymbolCode") as String?)!
                
                NSLog(lotPosition.SymbolCode)
                
                let investmentType = results!.stringForColumn("InvestmentType")

                if (ENumInvestmentType(rawValue: investmentType!) != nil)
                   
                {
                   lotPosition.InvestmentType = ENumInvestmentType(rawValue: investmentType!)!
                    // ENumInvestmentType(rawValue: investmentType!)!
                }
                else
                {
                    lotPosition.InvestmentType = ENumInvestmentType.Equity
                    
                }
                
               
                NSLog(lotPosition.InvestmentType.rawValue)

                let direction = results?.stringForColumn("Direction")!
                
                if (ENumDirection(rawValue: direction!) != nil)
                {
                    lotPosition.Direction = ENumDirection(rawValue: direction!)!
                }
                else
                {
                    lotPosition.Direction = ENumDirection.Long
                }
                
                
                
                lotPosition.RealizedGainLoss = results?.doubleForColumn("RealizedGainLoss") as Double!
                
                lotPosition.RealizedYear = Int(results?.intForColumn("Year") as Int32!)
                
                lotPosition.IsLongTerm = results?.boolForColumn("IsLongTerm") as Bool!
                lstLotPosition.append(lotPosition)
                
                
            }
            
            return lstLotPosition
        }
        
        return [LotPosition]()
    }
    
    func ReturnFilingStatus() -> [FilingStatus]
    {
        if self._capitalGainCalculatorDB.open()
        {
            
            var lstFilingStatus : [FilingStatus] = [FilingStatus]()
            
            let selectFilingStatusSql = "Select FilingStatusId, Year, FilingType, CurrentTaxableIncome, PreviouslyDeferredLoss From FilingStatus"
            
            NSLog(selectFilingStatusSql)
            
            
            let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectFilingStatusSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
            while results?.next() == true {
                
                let filingStatus = FilingStatus()
                
                filingStatus.FilingStatusId = results?.intForColumn("FilingStatusId") as Int32!
                
                NSLog(filingStatus.FilingStatusId.description)
                
                filingStatus.Year = Int(results?.intForColumn("Year") as Int32!)
                NSLog(filingStatus.Year.description)
                
                let filingType = results?.stringForColumn("FilingType")!
                filingStatus.FilingType =  ENumFilingType(rawValue: filingType! )!
                
                filingStatus.CurrentTaxableIncome = results?.doubleForColumn("CurrentTaxableIncome") as Double!
                
                NSLog(filingStatus.CurrentTaxableIncome.description)
                
                filingStatus.PreviouslyDeferredLoss = results?.doubleForColumn("PreviouslyDeferredLoss") as Double!
              
                NSLog(filingStatus.PreviouslyDeferredLoss.description)
                
                lstFilingStatus.append(filingStatus)
                
                
            }
            
            return lstFilingStatus
        }
        
        return [FilingStatus]()
    }
    
    
  
    
    func ReturnLotTerm(lstLotPosition : [LotPosition])-> [LotTerm]
    {
        if self._capitalGainCalculatorDB.open()
        {
            
            var selectedLots : String
            
            let equityInvestmentType = ENumInvestmentType.Equity.rawValue
            let qualifiedDividendInvestmentType = ENumInvestmentType.Dividend.rawValue
            let NonQualifiedDividendInvestmentType = ENumInvestmentType.NonQualifiedDividend.rawValue
            
             selectedLots = "(-1"
            
            for lot in lstLotPosition
            {
                if(lot.IsSelected)
                {
                    selectedLots = selectedLots +  ", " + lot.LotId.description
                }
            }
            
            selectedLots = selectedLots + ")"
            
            var lstLotTerm : [LotTerm] = [LotTerm]()
            
            let selectLotTermSql = "Select " +
            "Term " +
            ",Sum(RealizedGainLoss) as RealizedGainLoss " +
            ",Year " +
            "From " +
            "( " +
            "Select " +
            "SymbolCode " +
            ", InvestmentType " +
            ", Direction " +
            ",  sum(RealizedGainLoss) as RealizedGainLoss " +
            ", IsLongTerm " +
            ", Year " +
            ", Case When InvestmentType = '" + equityInvestmentType + "' and Direction ='Long' and IsLongTerm = 1 Then 'LongTerm' " +
            "When InvestmentType = '" + equityInvestmentType + "' and Direction = 'CoveredShort' and IsLongTerm = 1 Then 'LongTerm' " +
            "When InvestmentType = '" + qualifiedDividendInvestmentType + "'  Then 'LongTerm' " +
            "When InvestmentType = '" + NonQualifiedDividendInvestmentType + "'  Then 'ShortTerm' " +
            "When InvestmentType = 'Section 1256' Then 'Section1256' Else 'ShortTerm' " +
            "End as Term " +
            "From " +
            "LotPosition Where LotPositionId in " + selectedLots +
            " Group By " +
            "SymbolCode " +
            ", InvestmentType " +
            ", Direction " +
            ", IsLongTerm " +
            ", Year " +
            ") A " +
            "Group By " +
            "Term " +
            ",Year "
            
            NSLog(selectLotTermSql)
            
            
            let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectLotTermSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
            while results?.next() == true {
                
                    let lotTerm = LotTerm()

                
                    let term = results?.stringForColumn("Term")
                    NSLog(term!)
                
                    lotTerm.Term =  ENumTerm(rawValue: term! )!

                    lotTerm.TermRealizedGainLoss = results?.doubleForColumn("RealizedGainLoss") as Double!
                
                    NSLog(lotTerm.TermRealizedGainLoss.description)
                
                    lotTerm.Year = results?.intForColumn("Year") as Int32!
                
                    NSLog(lotTerm.Year.description)
                
                    lstLotTerm.append(lotTerm)
                
                
                      }

            return lstLotTerm
            
        }
        return [LotTerm]()
    }
    
    func ReturnDistinctYears() -> Array<Int32>
    {
        var arrYear = Array<Int32>()
        
        if self._capitalGainCalculatorDB.open()
        {
            let selectYearSql = "Select distinct(Year) From LotPosition order by Year Desc"
            
            NSLog(selectYearSql)
            
            let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectYearSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                
            }
            
            while results?.next() == true {
                
                let lotTerm = LotTerm()
                
                
                let year = results?.intForColumn("Year") as Int32!
                
                NSLog(year.description)
                
                arrYear.append(year)
                
            }
            
        }
        
        return arrYear
    }
    
    
}