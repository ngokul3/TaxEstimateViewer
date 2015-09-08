//
//  TaxViewController - ContainerViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/8/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class TaxViewControllerContainer: UIViewController , UIPickerViewDelegate {

    @IBOutlet weak var pickerYear: UIPickerView!
    
    @IBOutlet weak var txtLTCapitalGain: UILabel!
    
    @IBOutlet weak var txtSTCapitalGain: UILabel!
    
    
    @IBOutlet weak var txtTotalTax: UILabel!
    @IBOutlet weak var txtYear: UITextField!
   
    
    var yearArray = ["2015", "2014", "2013"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerYear.hidden = true
        
        var lstFilingStatus = CapitalGainController.sharedInstance.GetFilingStatus()
        
        let maxYear = lstFilingStatus.map{ return $0.Year }.reduce(Int.min, combine: {max($0, $1)} )
        
        txtYear.text = maxYear.description
        
        self.Refresh()
    }
    
    func Refresh()
    {
        var filingStatus : FilingStatus?
        
        var year : Int?
        
        year = txtYear.text.toInt()
        
        if (year == nil)
        {
            var alertNilYear = UIAlertController(title: "Year", message: "Please enter year in YYYY format", preferredStyle: UIAlertControllerStyle.Alert)
            alertNilYear.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))

            presentViewController(alertNilYear, animated: true, completion: nil)
            return
        }
        
        if (self.childViewControllers.count == 2)
        {
            let containerViewController = self.childViewControllers[0] as! ContainerInvestmentController
            
            containerViewController.lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(year!) //ToDO Validation)
            
           // let containerViewController = self.childViewControllers[0] as! UITableViewController
            containerViewController.tableView.reloadData()
            
            let filingStatus = containerViewController.CalculateCapitalGain()
            
            if(filingStatus == nil)
            {
                var alertNilFiling = UIAlertController(title: "Investment", message: "There are no Investments for the year.", preferredStyle: UIAlertControllerStyle.Alert)
                alertNilFiling.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                presentViewController(alertNilFiling, animated: true, completion: nil)
                return

            }
            
            
            if(filingStatus!.CurrentTaxableIncome != 0)
            {
                CapitalGainController.sharedInstance.SetResultFilingStatus(filingStatus!)
                
                let taxPageController = self.childViewControllers[1] as! TaxPageController
                taxPageController.RefreshTaxViewPages()
                
            }
            else
            {
                //ToDo Display Show segue to enter tax
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
 
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearArray.count
        
        
    }
  
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return yearArray[row]
    
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        txtYear.text = yearArray[row]
        
    }
    @IBAction func OnYearEditEnd(sender: AnyObject)
    {
     /*   pickerYear.hidden = true
        
        if(self.childViewControllers.count > 0)
        {
            let x = self.childViewControllers[0] as! ContainerInvestmentController
            
            let y = txtYear.text.toInt()!
            x.lstLotPositionForYear = CapitalGainController.sharedInstance.GetLotPositionForYear(y) //ToDO Validation)
    
            let containerViewController = self.childViewControllers[0] as! UITableViewController
            containerViewController.tableView.reloadData()
        }
        */
    }
    
    @IBAction func OnYearEditBegin(sender: AnyObject)
    {
       // pickerYear.hidden = false
        //pickerYear.bringSubviewToFront(self.view)
        
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
/*
protocol ResultsFilingStatus
{
    func GetResultsFilingStatus() -> FilingStatus
   
}*/