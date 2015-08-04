//
//  TaxViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/20/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class TaxViewController_Page: UIPageViewController {

    var databasePath = NSString()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cntPositions = CapitalGainController.sharedInstance.GetLotPositions().count
        
        
        let lotPositionDB = FMDatabase(path: databasePath as String)
        var arrayInvestments = CapitalGainController.sharedInstance.GetLotPositions()
        
       for index in 0...cntPositions-1{
        if lotPositionDB.open() {
            let lotPosition = CapitalGainController.sharedInstance.GetLotPositionItem(index)
            
            
            let insertSQL = "INSERT INTO LotPosition (SymbolCode, InvestmentType, Direction, RealizedGainLoss, Year, IsLongTerm) VALUES ('\(lotPosition.SymbolCode)', '\(lotPosition.InvestmentType)', '\(lotPosition.Direction)', '\(lotPosition.RealizedGainLoss)', '\(lotPosition.RealizedYear)', '\(lotPosition.IsLongTerm)')"
            
            let result = lotPositionDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
               println("Error: \(lotPositionDB.lastErrorMessage())")
            } 
        } else {
            println("Error: \(lotPositionDB.lastErrorMessage())")
        }

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
