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
       self._databasePath = _docsDir.stringByAppendingPathComponent("CapitalGain")
         self._filemgr = NSFileManager.defaultManager()
        self._capitalGainCalculatorDB = FMDatabase()
    }
    
    func OpenDatabase()->Bool
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        return self._capitalGainCalculatorDB.open()
    }
    
    func DeleteAll() -> Bool?
    {
        if self._capitalGainCalculatorDB.open()
        {
            
            let deleteLotPositionSql = "drop table FilingStatus "
            
            
            let results:Bool? = self._capitalGainCalculatorDB.executeUpdate (deleteLotPositionSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                
            }
            
            return results
        }
        
        return false
    }

    
    
    func CreateTable(){
        
            if !self._capitalGainCalculatorDB.open()
            {
                self._capitalGainCalculatorDB.open()
            }
            self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
            
            if self._capitalGainCalculatorDB == nil {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
            if self._capitalGainCalculatorDB.open() {
                let lotPositionTable = "CREATE TABLE IF NOT EXISTS LotPosition (LotPositionID INTEGER PRIMARY KEY AUTOINCREMENT, SymbolCode TEXT,  Direction TEXT, RealizedGainLoss DOUBLE, Year INTEGER, IsLongTerm BOOLEAN)"
                if !self._capitalGainCalculatorDB.executeStatements(lotPositionTable) {
                    print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
                
                let filingStatusTable = "CREATE TABLE IF NOT EXISTS FilingStatus (FilingStatusID INTEGER PRIMARY KEY AUTOINCREMENT, FilingType TEXT, Year INTEGER, CurrentTaxableIncome DOUBLE, PreviouslyDeferredLoss DOUBLE)"
                if !self._capitalGainCalculatorDB.executeStatements(filingStatusTable) {
                    print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
                
                self._capitalGainCalculatorDB.close()
            } else {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
       
    }
    
    func InsertInvestment(lotPosition: LotPosition) -> NSString
    {
        
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
     
        if self._capitalGainCalculatorDB.open()
        {
                let isLongTerm = lotPosition.IsLongTerm ? 1 : 0
              
                let insertSQL = "INSERT INTO LotPosition (SymbolCode, Direction, RealizedGainLoss, Year, IsLongTerm) VALUES ('\(lotPosition.SymbolCode)', '\(lotPosition.Direction.rawValue)', \(lotPosition.RealizedGainLoss), \(lotPosition.RealizedYear), \(isLongTerm))"
            
                NSLog(insertSQL)
                let result = self._capitalGainCalculatorDB.executeUpdate(insertSQL,
                    withArgumentsInArray: nil)
                
                if result {
                    let lastInsertedSql = "SELECT max(LotPositionID) as LotPositionID from LotPosition"
                    
                    let insertedResult:FMResultSet?  = self._capitalGainCalculatorDB.executeQuery(lastInsertedSql,
                        withArgumentsInArray: nil)
                    while insertedResult?.next() == true {
                    lotPosition.LotId = insertedResult!.intForColumn("LotPositionId") as Int32!
                    }
                }
            else
                {
                    print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
   
                }
            } else {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                return "Error"
            }
    
        return ""
    }
    
    func InsertFilingStatus(filingStatus: FilingStatus) -> NSString
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        if self._capitalGainCalculatorDB.open()
        {
            
            
            let insertSQL = "INSERT INTO FilingStatus (Year, FilingType, CurrentTaxableIncome) VALUES ('\(filingStatus.Year)', '\(filingStatus.FilingType.rawValue)', \(filingStatus.CurrentTaxableIncome))"
            
            let result = self._capitalGainCalculatorDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if result {
                let lastInsertedSql = "SELECT max(FilingStatusID) as FilingStatusID from FilingStatus"
                
                let insertedResult:FMResultSet?  = self._capitalGainCalculatorDB.executeQuery(lastInsertedSql,
                    withArgumentsInArray: nil)
                while insertedResult?.next() == true {
                    filingStatus.FilingStatusId = insertedResult!.intForColumn("FilingStatusId") as Int32!
                }
            }
            else
            {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                
            }
        } else {
            print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            return "Error"
        }
        
        return ""
    }

    func UpdateInvestment(lotPosition: LotPosition) -> NSString
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        if self._capitalGainCalculatorDB.open()
        {
            let isLongTerm = lotPosition.IsLongTerm ? 1 : 0
            
            
            let updateSQL = "Update LotPosition set SymbolCode = '\(lotPosition.SymbolCode)', Direction = '\(lotPosition.Direction.rawValue)', RealizedGainLoss = \(lotPosition.RealizedGainLoss), Year = \(lotPosition.RealizedYear), IsLongTerm = \(isLongTerm) Where LotPositionId = \(lotPosition.LotId)" //TODO
            
            let result = self._capitalGainCalculatorDB.executeUpdate(updateSQL,
                withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
        } else {
            print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            return "Error"
        }
        
        return ""
    }
    
    func UpdateFilingStatus(filingStatus: FilingStatus) -> NSString
    {
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        if self._capitalGainCalculatorDB.open()
        {
            
            let updateSQL = "Update FilingStatus set Year = \(filingStatus.Year), FilingType = '\(filingStatus.FilingType.rawValue)', CurrentTaxableIncome = \(filingStatus.CurrentTaxableIncome) Where FilingStatusId = \(filingStatus.FilingStatusId)"
            
            let result = self._capitalGainCalculatorDB.executeUpdate(updateSQL,
                withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
        } else {
            print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            return "Error"
        }
        
        return ""
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
            print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            
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
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                
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
            
            let selectLotPositionSql = "Select LotPositionID, SymbolCode, Direction, RealizedGainLoss, Year, IsLongTerm From LotPosition Order By SymbolCode Asc, RealizedGainLoss Desc"
            
            NSLog(selectLotPositionSql)
            
            
            let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectLotPositionSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }

            while results?.next() == true {
                
                let lotPosition = LotPosition()
                
                lotPosition.LotId = results?.intForColumn("LotPositionID") as Int32!
                
                NSLog(lotPosition.LotId.description)
                
                lotPosition.SymbolCode = (results?.stringForColumn("SymbolCode") as String?)!
                
                NSLog(lotPosition.SymbolCode)
                
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
            
            let selectFilingStatusSql = "Select FilingStatusId, Year, FilingType, CurrentTaxableIncome From FilingStatus Order by Year Desc"
            
            NSLog(selectFilingStatusSql)
            
            
            let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectFilingStatusSql,
                withArgumentsInArray: nil)
            
            if !(results != nil) {
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
            while results?.next() == true {
                
                let filingStatus = FilingStatus()
                
                filingStatus.FilingStatusId = results?.intForColumn("FilingStatusId") as Int32!
                
                
                filingStatus.Year = Int(results?.intForColumn("Year") as Int32!)
             
                let filingType = results?.stringForColumn("FilingType")!
                filingStatus.FilingType =  ENumFilingType(rawValue: filingType! )!
                
                filingStatus.CurrentTaxableIncome = results?.doubleForColumn("CurrentTaxableIncome") as Double!
                
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
            ", Direction " +
            ",  sum(RealizedGainLoss) as RealizedGainLoss " +
            ", IsLongTerm " +
            ", Year " +
            ", Case When Direction ='Long' and IsLongTerm = 1 Then 'LongTerm' " +
            "When Direction = 'CoveredShort' and IsLongTerm = 1 Then 'LongTerm' " +
            "Else 'ShortTerm' " +
            "End as Term " +
            "From " +
            "LotPosition Where LotPositionId in " + selectedLots +
            " Group By " +
            "SymbolCode " +
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
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
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
                print("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                
            }
            
            while results?.next() == true {
                
                // //Convert let lotTerm = LotTerm()
                
                
                let year = results?.intForColumn("Year") as Int32!
                
                NSLog(year.description)
                
                arrYear.append(year)
                
            }
            
        }
        
        return arrYear
    }
    
    
}