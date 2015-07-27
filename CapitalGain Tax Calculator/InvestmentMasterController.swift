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

    @IBOutlet weak var txtLabelTest: UILabel!
    
  //  @IBOutlet var viewInvestments: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // viewInvestments.dataSource = self
        //viewInvestments.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /*self.lotPosition.append(LotPosition(symbolCode:"AAPL", symbolDesc:"Apple"))
        self.lotPosition.append(LotPosition(symbolCode:"CTSH", symbolDesc:"Cognizant"))
               self.lotPosition.append(LotPosition(symbolCode:"TCS", symbolDesc:"TCS"))*/

    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var recordCount = CapitalGainController.sharedInstance.GetInvestments().count
        return recordCount
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        
        let cellIdentifier = "InvestmentTableViewCell"
        
        let lotPosition = CapitalGainController.sharedInstance.GetPositionItem(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InvestmentTableViewCell
        cell.lblInvesmentName.text = lotPosition.SymbolCode
        return cell
    }
    
    
    // UITableViewDelegate Functions
    
   /* override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    */
  /*  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedLot = self.lotPosition[indexPath.row]
       // self.delegate?.lotSelected(selectedLot)
       /*
        if let detailViewController = self.delegate as? StockDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }*/
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
       
            var x = 10
         
    }
    
    @IBAction func unwindToInvestmentList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddInvestmentController{
            
            var arrayInvestments = CapitalGainController.sharedInstance.GetInvestments()
            
            let newIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            
           // tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            tableView.reloadData()
        }
    }
}
  

