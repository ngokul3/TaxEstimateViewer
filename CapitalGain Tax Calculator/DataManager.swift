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
    
    
    func CreateTable(){
        if !self._filemgr.fileExistsAtPath(_databasePath as String) {
            
            self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
            
            if self._capitalGainCalculatorDB == nil {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
            if self._capitalGainCalculatorDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS LotPosition (LotPositionID INTEGER PRIMARY KEY AUTOINCREMENT, SymbolCode TEXT, InvestmentType TEXT, Direction TEXT, RealizedGainLoss DOUBLE, Year INTEGER, IsLongTerm BOOLEAN)"
                if !self._capitalGainCalculatorDB.executeStatements(sql_stmt) {
                    println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
                self._capitalGainCalculatorDB.close()
            } else {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
        }
    }
    
    func InsertInvestments()
    {
        var arrayInvestments = CapitalGainController.sharedInstance.GetInvestments()
        let cntPositions = CapitalGainController.sharedInstance.GetInvestments().count
        self._capitalGainCalculatorDB = FMDatabase(path: _databasePath as String)
        
        for index in 0...cntPositions-1 {
            if self._capitalGainCalculatorDB.open() {
                let lotPosition = CapitalGainController.sharedInstance.GetPositionItem(index)
                
                
                let insertSQL = "INSERT INTO LotPosition (SymbolCode, InvestmentType, Direction, RealizedGainLoss, Year, IsLongTerm) VALUES ('\(lotPosition.SymbolCode)', '\(lotPosition.InvestmentType.rawValue)', '\(lotPosition.Direction.rawValue)', \(lotPosition.RealizedGainLoss), \(lotPosition.RealizedYear), \(1))" //TODO
                
                let result = self._capitalGainCalculatorDB.executeUpdate(insertSQL,
                    withArgumentsInArray: nil)
                
                if !result {
                    NSLog("otPositionDB.lastErrorMessage()")
                    println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
                }
            } else {
                println("Error: \(self._capitalGainCalculatorDB.lastErrorMessage())")
            }
            
        }
        
        let selectSql = "SELECT SymbolCode, Direction, RealizedGainLoss FROM LotPosition"
        let results:FMResultSet? = self._capitalGainCalculatorDB.executeQuery(selectSql,
            withArgumentsInArray: nil)
        
        
        while results?.next() == true {
            let symbol = results?.stringForColumn("SymbolCode")
            NSLog(symbol!)
        }
    }
}