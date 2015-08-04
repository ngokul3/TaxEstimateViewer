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

    @IBOutlet weak var txtLabelTest: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CapitalGainController.sharedDBInstance.CreateTable()
        if CapitalGainController.sharedDBInstance.OpenDatabase(){

            
        let lstLotPosition = CapitalGainController.sharedDBInstance.ReturnLotPosition()
            
        LoadLotPosition(lstLotPosition)
        }
        
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
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
       
            var x = 10
         
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
  

