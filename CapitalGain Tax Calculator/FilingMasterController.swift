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

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordCount = CapitalGainController.sharedInstance.GetFilingStatus().count
        return recordCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        
        let cellIdentifier = "FilingTableViewCell"
        
        let filingStatus = CapitalGainController.sharedInstance.GetFilingStatusItem(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FilingTableViewCell
        cell.lblFilingStatus.text = filingStatus.Year.description
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let filingStatus = CapitalGainController.sharedInstance.GetFilingStatusItem(indexPath.row)
        let isSuccess = CapitalGainController.sharedDBInstance.DeleteFilingStatus(filingStatus)
        
        if ((isSuccess) != nil)
        {
            CapitalGainController.sharedInstance.DeleteFilingStatusItem(indexPath.row)
            tableView.reloadData()
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            
            if (segue.identifier == "AddFilingDetail")
            {
                
                if let addViewController = segue.destinationViewController as? AddFilingController{
                    addViewController.navigationItem.title = "Add Filing Detail"
                    addViewController.selectedFilingDetail = nil
                }
                
                
            }
            else if (segue.identifier == "EditFilingDetail")
            {
                
                if let editViewController = segue.destinationViewController as? AddFilingController{
                    
                    if let row = tableView.indexPathForSelectedRow!.row as? Int //Convert
                    {
                        let selectedFilingDetail = CapitalGainController.sharedInstance.GetFilingStatusItem(row)
                        editViewController.selectedFilingDetail = selectedFilingDetail
                        editViewController.navigationItem.title = "Edit Filing Detail"
                    }
                    
                }
                
            }
            
    }
    
    @IBAction func unwindToFilingStatusList(sender: UIStoryboardSegue) {
        if let _ = sender.sourceViewController as? AddFilingController{
            
           // _ = CapitalGainController.sharedInstance.GetFilingStatus()
            
            //_ = NSIndexPath(forRow: 1, inSection: 0) // Convert
            
            tableView.reloadData()
        }
    }

}
