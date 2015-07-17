//
//  MasterViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit
protocol LotSelectionDelegate: class {
    func lotSelected(newlotPosition: LotPosition)
}



class MasterViewController: UITableViewController {
weak var delegate:LotSelectionDelegate?
    var lotPosition =   [LotPosition]()

    override func viewDidLoad() {
        super.viewDidLoad()

         //  let lotPosition =
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.lotPosition.append(LotPosition(symbolCode:"AAPL", symbolDesc:"Apple"))
        self.lotPosition.append(LotPosition(symbolCode:"CTSH", symbolDesc:"Cognizant"))
               self.lotPosition.append(LotPosition(symbolCode:"TCS", symbolDesc:"TCS"))

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedLot = self.lotPosition[indexPath.row]
        self.delegate?.lotSelected(selectedLot)
        
        if let detailViewController = self.delegate as? StockDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
       
            var x = 10
            
          /*  if segue.identifier == "showDetail" {
                if let indexPath = self.tableView.indexPathForSelectedRow() {
                    let urlString = siteAddresses?[indexPath.row]
                    
                    let controller = (segue.destinationViewController
                        as UINavigationController).topViewController
                        as! StockDetailViewController
                    
                    controller.detailItem = urlString
                    controller.navigationItem.leftBarButtonItem =
                        splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }*/
    }
  
}
