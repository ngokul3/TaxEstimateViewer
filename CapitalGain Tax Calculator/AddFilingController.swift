//
//  AddFilingController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/27/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class AddFilingController: UIViewController , UIPickerViewDelegate{

    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var stpYear: UIStepper!
    
    @IBOutlet weak var txtFilingMode: UITextField!
    
    @IBOutlet weak var txtCurrentTaxableIncome: UITextField!
    
    @IBOutlet weak var txtPreviouslyDeferredLoss: UITextField!
    
    @IBOutlet weak var pickerFilingMode: UIPickerView!
    
    @IBOutlet weak var btnAddFilingStatus: UIBarButtonItem!
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if btnAddFilingStatus === sender {
            let itemCount = CapitalGainController.sharedInstance.GetFilingStatus().count
            let filingStatus = FilingStatus()
            filingStatus.Year = lblYear.text!.toInt()!
            filingStatus.FilingType = ENumFilingType(rawValue: txtFilingMode.text)!
            filingStatus.CurrentTaxableIncome = txtCurrentTaxableIncome.text!.toDouble()!
            filingStatus.PreviouslyDeferredLoss = txtPreviouslyDeferredLoss.text!.toDouble()!
            CapitalGainController.sharedInstance.AddFilingStatus(filingStatus)
            
            var returnString = CapitalGainController.sharedDBInstance.InsertFilingStatus(filingStatus)
        }
    }
}


