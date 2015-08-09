//
//  ContainerInvestmentController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/9/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ContainerInvestmentController: UITableViewController {

    @IBOutlet var investmentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CapitalGainController.sharedDBInstance.CreateTable()
       if CapitalGainController.sharedDBInstance.OpenDatabase(){
            
            
            let lstLotPosition = CapitalGainController.sharedDBInstance.ReturnLotPosition()
            
            LoadLotPosition(lstLotPosition)
        }
        
    }

        func LoadLotPosition(lstLotPosition: [LotPosition])
        {
            if lstLotPosition.count > 0
            {
                for lotPosition in lstLotPosition
                {
                    CapitalGainController.sharedInstance.AddLotPosition(lotPosition)
                }
                
            }
        }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // TODO:
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var recordCount = CapitalGainController.sharedInstance.GetLotPositions().count
        return recordCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        
        let cellIdentifier = "InvestmentTableViewCell"
        
        let lotPosition = CapitalGainController.sharedInstance.GetLotPositionItem(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InvestmentTableViewCell
        cell.lblInvesmentName.text = lotPosition.SymbolCode
        return cell
    }

  

}
