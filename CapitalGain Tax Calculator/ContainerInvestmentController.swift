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
 
    var utils = Utils()
    var lstLotPositionForYear = [LotPosition]()
    var taxProcessor = TaxProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let taxViewController =  self.presentedViewController

    }

    override func viewWillAppear(animated: Bool) {
          let taxViewController =  self.presentedViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // TODO:
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var recordCount = lstLotPositionForYear.count
        return recordCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        
        
        let cellIdentifier = "InvestmentTableViewCell"
        
        let lotPosition = lstLotPositionForYear[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InvestmentTableViewCell
        cell.lblInvesmentName.text = lotPosition.SymbolCode
        cell.lblProfitLoss.text = utils.ConvertStringToCurrency(lotPosition.RealizedGainLoss.description)
        let imgLTSTImageView = cell.viewWithTag(30) as! UIImageView
        imgLTSTImageView.image = cell.ImageForLTST(lotPosition.Direction)
        
        let img365View = cell.viewWithTag(40) as! UIImageView
        img365View.image = cell.ImageFor365(lotPosition.IsLongTerm)
        
        if(lotPosition.RealizedGainLoss > 0)
        {
            cell.lblProfitLoss.textColor = UIColor.greenColor()
        }
        else
        {
            cell.lblProfitLoss.textColor = UIColor.redColor()
        }

        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if( cell?.accessoryType == UITableViewCellAccessoryType.Checkmark)
      {
            cell?.setSelected(false, animated: false)
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            cell?.accessoryType = UITableViewCellAccessoryType.None
        
            lstLotPositionForYear[indexPath.row].IsSelected = false
        }
        
        else
       {
            cell?.setSelected(true, animated: false)
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        
            lstLotPositionForYear[indexPath.row].IsSelected = true

        }
    }
    
    func CalculateCapitalGain()->FilingStatus?
    {
        if (lstLotPositionForYear.filter({m in m.IsSelected == true}).count > 0)
        {
            
            let lstLotPositionSelected = lstLotPositionForYear.filter({m in m.IsSelected == true})
            let year = lstLotPositionForYear.map{ return $0.RealizedYear }.first
            
            let filingStatus = CapitalGainController.sharedInstance.GetFilingStatusForYear(year!)
            
            let lstLotTerm = CapitalGainController.sharedDBInstance.ReturnLotTerm(lstLotPositionSelected)
           // let taxProcessor = TaxProcessor()
            
            RefreshInvestments()

            if(lstLotTerm.count > 0 && filingStatus != nil)
            {
            
                let filingStatus = taxProcessor.GetTaxableIncome(filingStatus!, lstLotTerm: lstLotTerm)
                
                return filingStatus
            }
        }
        
        return nil
        
    }
    
   func RefreshInvestments()
   {
        tableView.reloadData()

    }
}
