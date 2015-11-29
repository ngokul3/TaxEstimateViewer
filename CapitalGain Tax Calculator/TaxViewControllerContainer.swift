//
//  TaxViewController - ContainerViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/8/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class TaxViewControllerContainer: UIViewController  {

    @IBOutlet weak var txtYear: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = NSDate()
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date)
    
        let currentYear = components.year
        
        
        addToolBar(self.txtYear)
        let lstFilingStatus = CapitalGainController.sharedInstance.GetFilingStatus()
        
        if(lstFilingStatus.count == 0)
        {
            txtYear.text = currentYear.description
        }
        else
        {
            let maxYear = lstFilingStatus.map{ return $0.Year }.reduce(Int.min, combine: {max($0, $1)} )
        
            txtYear.text = maxYear.description
        }
        self.Refresh()
    }
    
    func Refresh()
    {
        //var filingStatus : FilingStatus? //Convert
        
        var year : Int?
        
        year = txtYear.text!.toInt()
        
        if (year == nil)
        {
            let alertNilYear = UIAlertController(title: "Year", message: "Please enter year in YYYY format", preferredStyle: UIAlertControllerStyle.Alert)
            alertNilYear.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))

            presentViewController(alertNilYear, animated: true, completion: nil)
            
            RefreshContainers(FilingStatus())
    
            
            return
        }
        
        if (self.childViewControllers.count > 0)
        {
            let containerViewController = self.childViewControllers[0] as! ContainerInvestmentController
            
            containerViewController.lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(year!)
            containerViewController.tableView.reloadData()
            
            let isFilingStatusavailable = CapitalGainController.sharedInstance.GetFilingStatusForYear(year!)
            
            if(isFilingStatusavailable == nil)
            {
                let alertNilFiling = UIAlertController(title: "FilingMode", message: "Tax Filing Mode information missing for the year.", preferredStyle: UIAlertControllerStyle.Alert)
                alertNilFiling.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                presentViewController(alertNilFiling, animated: true, completion: nil)
                
                RefreshContainers(FilingStatus())
                
                return
                
            }
            
            
            let filingStatus = containerViewController.CalculateCapitalGain()
            
            if(filingStatus == nil)
            {
                let alertNilFiling = UIAlertController(title: "Investment", message: "There are no Investments available / selected for the year.", preferredStyle: UIAlertControllerStyle.Alert)
                alertNilFiling.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                presentViewController(alertNilFiling, animated: true, completion: nil)
                
                RefreshContainers(FilingStatus())
                
                return

            }
            
            if(filingStatus?.NetLoss != 0)
            {
                let alertNilFiling = UIAlertController(title: "Net Loss", message: "There is no Taxable Capital Gain due to total loss.", preferredStyle: UIAlertControllerStyle.Alert)
                alertNilFiling.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                presentViewController(alertNilFiling, animated: true, completion: nil)
                
                RefreshContainers(FilingStatus())
                
                return
                
            }
            
            if(filingStatus!.CurrentTaxableIncome != 0)
            {
                RefreshContainers(filingStatus!)
            }
            else
            {
                RefreshContainers(FilingStatus())
            }
        }
    }

    func RefreshContainers(filingStatus : FilingStatus)
    {
        CapitalGainController.sharedInstance.SetResultFilingStatus(filingStatus)
        
        let taxPageController = self.childViewControllers[1] as! TaxPageController
        taxPageController.RefreshTaxViewPages()
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            
        let identifier = segue.identifier
        if ( identifier == "ShowInvestments")
        {
        
            let viewController1 = segue.destinationViewController as! ContainerInvestmentController
        
            self.addChildViewController(viewController1)
        }
            
        
    }
    
    @IBAction func btnRefresh(sender: AnyObject) {
        
        self.Refresh()
      
        
    }
    

}
