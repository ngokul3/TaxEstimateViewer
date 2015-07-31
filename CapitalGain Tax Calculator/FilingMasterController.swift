//
//  FilingMasterController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/20/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class FilingMasterController: UITableViewController {
    var databasePath = NSString()

 //var filingStatus =   [FilingStatus]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
       
        
        let cntPositions = CapitalGainController.sharedInstance.GetInvestments().count
        databasePath = docsDir.stringByAppendingPathComponent(
            "Test1")
        
        let lotPositionDB = FMDatabase(path: databasePath as String)
        var arrayInvestments = CapitalGainController.sharedInstance.GetInvestments()
        
        for index in 0...cntPositions-1 {
            if lotPositionDB.open() {
                let lotPosition = CapitalGainController.sharedInstance.GetPositionItem(index)
                
                
                let insertSQL = "INSERT INTO LotPosition (SymbolCode, InvestmentType, Direction, RealizedGainLoss, Year, IsLongTerm) VALUES ('\(lotPosition.SymbolCode)', '\(lotPosition.InvestmentType.rawValue)', '\(lotPosition.Direction.rawValue)', \(lotPosition.RealizedGainLoss), \(lotPosition.RealizedYear), \(1))"
                
                let result = lotPositionDB.executeUpdate(insertSQL,
                    withArgumentsInArray: nil)
                
                if !result {
                    NSLog("otPositionDB.lastErrorMessage()")
                    println("Error: \(lotPositionDB.lastErrorMessage())")
                }
            } else {
                println("Error: \(lotPositionDB.lastErrorMessage())")
            }
            
        }
        
        let selectSql = "SELECT SymbolCode, Direction, RealizedGainLoss FROM LotPosition"
        let results:FMResultSet? = lotPositionDB.executeQuery(selectSql,
            withArgumentsInArray: nil)
        
        
        while results?.next() == true {
            let symbol = results?.stringForColumn("SymbolCode")
           NSLog(symbol!)
        }
      //      NSLog(results?.stringForColumn("Cnt")!)
        
        /*if !(result != nil) {
            NSLog("otPositionDB.lastErrorMessage()")
            println("Error: \(lotPositionDB.lastErrorMessage())")
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // TODO:
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var recordCount = CapitalGainController.sharedInstance.GetFilingStatus().count
        return recordCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        
        let cellIdentifier = "FilingTableViewCell"
        
        let filingStatus = CapitalGainController.sharedInstance.GetFilingStatusItem(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FilingTableViewCell
        cell.lblFilingStatus.text = filingStatus.Year.description
        return cell
    }

    @IBAction func unwindToFilingStatusList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddFilingController{
            
            var arrayInvestments = CapitalGainController.sharedInstance.GetFilingStatus()
            
            let newIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            
            // tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            tableView.reloadData()
        }
    }

}
