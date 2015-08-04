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

        let lstLotPosition = CapitalGainController.sharedInstance.GetLotPositions()
        let lstFilingStatus = CapitalGainController.sharedInstance.GetFilingStatus()
        
        let filingStatus = lstFilingStatus.first
        
        let taxProcessor = TaxProcessor()
        
        let lstLotTerm = taxProcessor.GetLotsByTerm()
        
        taxProcessor.GetTaxableIncome(filingStatus!, lstLotTerm: lstLotTerm)
      
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
