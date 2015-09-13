//
//  AddFilingController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/27/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class AddFilingController: UIViewController , UIPickerViewDelegate{

    var utils = Utils()
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var stpYear: UIStepper!
    
    @IBOutlet weak var txtFilingMode: UITextField!
    
    @IBOutlet weak var txtCurrentTaxableIncome: UITextField!
    
    @IBOutlet weak var txtPreviouslyDeferredLoss: UITextField!
    
    @IBOutlet weak var pickerFilingMode: UIPickerView!
    
    @IBOutlet weak var btnAddFilingStatus: UIBarButtonItem!
    
    var selectedFilingDetail : FilingStatus?
    
    var filingModeArray = [ENumFilingType.Single.rawValue,ENumFilingType.Joint.rawValue,ENumFilingType.Separate.rawValue,ENumFilingType.HoH.rawValue]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerFilingMode.hidden = true
        let date = NSDate()
        var dateFormatter = NSDateFormatter()
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear, fromDate: date)
        let year = components.year
        
        lblYear.text = year.description
        stpYear.value = Double(year)
        
        stpYear.maximumValue = 2030 // TODO:
        stpYear.stepValue = 1
        
        if (selectedFilingDetail != nil)
        {
            println("This is filing detail edit")
            stpYear.enabled = false
            lblYear.text = selectedFilingDetail?.Year.description
            txtCurrentTaxableIncome.text = utils.ConvertStringToCurrency(selectedFilingDetail?.CurrentTaxableIncome.description)
            txtFilingMode.text = selectedFilingDetail?.FilingType.rawValue
            
           // txtPreviouslyDeferredLoss.text = selectedFilingDetail?.PreviouslyDeferredLoss.description
            txtPreviouslyDeferredLoss.text = utils.ConvertStringToCurrency(selectedFilingDetail?.PreviouslyDeferredLoss.description)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OntxtCurrentTaxableIncomeEditDidBegin(sender: AnyObject) {
        txtCurrentTaxableIncome.text = utils.ConvertCurrencyToString(txtCurrentTaxableIncome.text)
        
    }
    @IBAction func OntxtCurrentTaxableIncomeEditDidEnd(sender: AnyObject) {
        txtCurrentTaxableIncome.text = utils.ConvertStringToCurrency(txtCurrentTaxableIncome.text)
        
    }
    
    @IBAction func OntxtPreviouslyDeferredLossEditDidBegin(sender: AnyObject) {
        txtPreviouslyDeferredLoss.text = utils.ConvertCurrencyToString(txtPreviouslyDeferredLoss.text)

    }
    @IBAction func OntxtPreviouslyDeferredLossEditDidEnd(sender: AnyObject) {
        txtPreviouslyDeferredLoss.text = utils.ConvertStringToCurrency(txtPreviouslyDeferredLoss.text)
        
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
          return filingModeArray.count
       
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       
            return filingModeArray[row]
        
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
            txtFilingMode.text = filingModeArray[row]
    }
    
    
    @IBAction func OnStpYearValueChanged(sender: AnyObject) {
        lblYear.text = Int(stpYear.value).description
    }

    @IBAction func OnFilingModeEditEnd(sender: AnyObject) {
        pickerFilingMode.hidden = true
    }
    
    
    @IBAction func OnFilingModeEditBegin(sender: AnyObject) {
        pickerFilingMode.hidden = false
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool // Invoked immediately prior to
    {
        txtCurrentTaxableIncome.text = utils.ConvertCurrencyToString(txtCurrentTaxableIncome.text)
        txtPreviouslyDeferredLoss.text = utils.ConvertCurrencyToString(txtPreviouslyDeferredLoss.text)
        
        
        var alertFilingMode = UIAlertController(title: "Filing Mode", message: "Filing Mode is required", preferredStyle: UIAlertControllerStyle.Alert)
        alertFilingMode.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        var alertAnnualIncome = UIAlertController(title: "Annual Income", message: "Annual Income should be numeric", preferredStyle: UIAlertControllerStyle.Alert)
        alertAnnualIncome.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        var alertDeferredLoss = UIAlertController(title: "Deferred Loss", message: "Deferred Loss should be numeric", preferredStyle: UIAlertControllerStyle.Alert)
        alertDeferredLoss.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
 
        var alertYear = UIAlertController(title: "Filing Year", message: "Year should be in YYYY format", preferredStyle: UIAlertControllerStyle.Alert)
        alertYear.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
         }))
        

        var alertFilingAlreadyAvailable = UIAlertController(title: "Filing Year", message: "Filing information already added for this Year", preferredStyle: UIAlertControllerStyle.Alert)
        alertFilingAlreadyAvailable.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
           // println("Filing information already added for this Year")
        }))
        
        let lstFilingStatus = CapitalGainController.sharedInstance.GetFilingStatus()
        
        let recordCount = lstFilingStatus.filter({m in m.Year == self.lblYear.text!.toInt()}).count as Int!
        
        if (txtFilingMode.text.isEmpty)
        {
            presentViewController(alertFilingMode, animated: true, completion: nil)
            return false
        }
        else if(txtCurrentTaxableIncome.text.toDouble() == nil)
        {
            presentViewController(alertAnnualIncome, animated: true, completion: nil)
            return false
        }
        else if(txtPreviouslyDeferredLoss.text.isEmpty == false && txtPreviouslyDeferredLoss.text.toDouble() == nil)
        {
            presentViewController(alertDeferredLoss, animated: true, completion: nil)
            return false
        }
        else if(lblYear.text!.toInt() == nil)
        {
            
            presentViewController(alertYear, animated: true, completion: nil)
            return false
        }
        else if (self.selectedFilingDetail == nil && recordCount != nil && recordCount > 0)
        {
            presentViewController(alertFilingAlreadyAvailable, animated: true, completion: nil)

            return false
        }
        else
        {
            return true
        }
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var filingStatus = FilingStatus()

        if btnAddFilingStatus === sender
        {
            filingStatus.Year = lblYear.text!.toInt()!
            filingStatus.FilingType = ENumFilingType(rawValue: txtFilingMode.text)!
            filingStatus.CurrentTaxableIncome = txtCurrentTaxableIncome.text!.toDouble()!
            filingStatus.PreviouslyDeferredLoss = txtPreviouslyDeferredLoss.text!.toDouble()!

            if(self.selectedFilingDetail != nil)
            {
                filingStatus.FilingStatusId = selectedFilingDetail!.FilingStatusId
                CapitalGainController.sharedInstance.UpdateFilingStatus(filingStatus)
                CapitalGainController.sharedDBInstance.UpdateFilingStatus(filingStatus)
            }
            else
            {
                
                CapitalGainController.sharedInstance.AddFilingStatus(filingStatus)
                CapitalGainController.sharedDBInstance.InsertFilingStatus(filingStatus)
            
            }

        }
    }
}


