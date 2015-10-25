//
//  MasterViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class InvestmentMasterController: UITableViewController {
    var lotPosition =   [LotPosition]()
    var databasePath = NSString()
    var utils = Utils()
    var arrYears = Array<Int32>()

    @IBOutlet var investmentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CapitalGainController.sharedDBInstance.CreateTable()
        if CapitalGainController.sharedDBInstance.OpenDatabase(){
       //let x = CapitalGainController.sharedDBInstance.DeleteAll()
        let lstLotPosition = CapitalGainController.sharedDBInstance.ReturnLotPosition()
        let lstFilingStatus = CapitalGainController.sharedDBInstance.ReturnFilingStatus()
        LoadLotPosition(lstLotPosition)
        LoadFilingStatus(lstFilingStatus)
        }
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     

    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        arrYears = CapitalGainController.sharedDBInstance.ReturnDistinctYears()
        return arrYears.count
       
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return arrYears[section].description
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let year = arrYears[section].description.toInt()
        
        let lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(year!)
        
        return lstLotPositionForYear.count
        }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        
        let cellIdentifier = "InvestmentTableViewCell"
        
        let year = arrYears[indexPath.section].description.toInt()
        
        let lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(year!)
        let lotPosition = lstLotPositionForYear[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InvestmentTableViewCell
        cell.lblInvesmentName.text = lotPosition.SymbolCode
        cell.lblProfitLoss.text = utils.ConvertStringToCurrency(lotPosition.RealizedGainLoss.description)
        
        if(lotPosition.RealizedGainLoss > 0)
        {
            cell.lblProfitLoss.textColor = UIColor.greenColor()
        }
        else
        {
            cell.lblProfitLoss.textColor = UIColor.redColor()
        }
        let imgLTSTImageView = cell.viewWithTag(30) as! UIImageView
        imgLTSTImageView.image = cell.ImageForLTST(lotPosition.Direction)
        
        let img365View = cell.viewWithTag(40) as! UIImageView
        img365View.image = cell.ImageFor365(lotPosition.IsLongTerm)
        
   
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let section = indexPath.section
        
        let row = indexPath.row
        
        let year = arrYears[section].description.toInt()
        
        let lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(year!)
        
        let selectedLotPosition = lstLotPositionForYear[row]
        
       // let lotPosition = CapitalGainController.sharedInstance.GetLotPositionItem(indexPath.row)
        let isSuccess = CapitalGainController.sharedDBInstance.DeleteLotPosition(selectedLotPosition)
        
        if ((isSuccess) != nil)
        {
            CapitalGainController.sharedInstance.DeleteLotPositionItem(selectedLotPosition)
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
                    
                    let section = tableView.indexPathForSelectedRow()?.section
                    
                    let row = tableView.indexPathForSelectedRow()?.row
                    
                    let year = arrYears[section!].description.toInt()
                    
                    let lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(year!)
                    
                    let selectedLotPosition = lstLotPositionForYear[row!]
                    
                    editViewController.selectedLotPosition = selectedLotPosition
                    editViewController.navigationItem.title = "Edit Investment"
                 
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
    
    func LoadFilingStatus(lstFilingStatus: [FilingStatus])
    {
        if lstFilingStatus.count > 0
        {
            for filingStatus in lstFilingStatus
            {
                CapitalGainController.sharedInstance.AddFilingStatus(filingStatus)
            }
            
        }
    }
    
    @IBAction func unwindToInvestmentList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddInvestmentController{
            
             tableView.reloadData()
        }
    }
    


}


