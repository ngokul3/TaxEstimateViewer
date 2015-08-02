//
//  TaxViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/2/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class TaxViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let arrayLotPosition = CapitalGainController.sharedInstance.GetInvestments()
        let arrayFilingStatus = CapitalGainController.sharedInstance.GetFilingStatus()
        
        let filingStatus = arrayFilingStatus.firstObject as! FilingStatus
        
        let taxProcessor = TaxProcessor()
        
       
        let lotTerm = taxProcessor.GetLotsByTerm()
        
        taxProcessor.GetTaxableIncome(filingStatus, arrayLotPosition: arrayLotPosition)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

   

}
