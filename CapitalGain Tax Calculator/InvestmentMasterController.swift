//
//  MasterViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit
/*protocol LotSelectionDelegate: class {
    func lotSelected(newlotPosition: LotPosition)
}*/



class InvestmentMasterController: UITableViewController {
//weak var delegate:LotSelectionDelegate?
    var lotPosition =   [LotPosition]()
    var databasePath = NSString()

    @IBOutlet var investmentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CapitalGainController.sharedDBInstance.CreateTable()
        if CapitalGainController.sharedDBInstance.OpenDatabase(){

            
        let lstLotPosition = CapitalGainController.sharedDBInstance.ReturnLotPosition()
            
        LoadLotPosition(lstLotPosition)
        }
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     

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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let lotPosition = CapitalGainController.sharedInstance.GetLotPositionItem(indexPath.row)
        let isSuccess = CapitalGainController.sharedDBInstance.DeleteLotPosition(lotPosition)
        
        if ((isSuccess) != nil)
        {
            CapitalGainController.sharedInstance.DeleteLotPositionItem(indexPath.row)
            tableView.reloadData()

        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
       
           if (segue.identifier == "AddInvestment")
            {
                
                if let addViewController = segue.destinationViewController as? AddInvestmentController{
                    addViewController.navigationItem.title = "Add Investment"
                    addViewController.selectedLotPosition = nil
                }
                
                
            }
            else if (segue.identifier == "EditInvestment")
            {
                
                if let editViewController = segue.destinationViewController as? AddInvestmentController{
                    
                    if let index = tableView.indexPathForSelectedRow()?.row
                    {
                        let selectedLotPosition = CapitalGainController.sharedInstance.GetLotPositionItem(index)
                        editViewController.selectedLotPosition = selectedLotPosition
                        editViewController.navigationItem.title = "Edit Investment"
                    }
                 
                }
                
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
    
    @IBAction func unwindToInvestmentList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddInvestmentController{
            
        //    var arrayInvestments = CapitalGainController.sharedInstance()
            
          //  let newIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            
           // tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            tableView.reloadData()
        }
    }
}
  

