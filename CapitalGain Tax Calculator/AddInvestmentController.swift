//
//  AddStockViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/16/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class AddInvestmentController: UIViewController, UIPickerViewDelegate{
    
    @IBOutlet weak var btnAddInvestment: UIBarButtonItem!
    
    @IBOutlet weak var txtSymbol: UITextField!
    
    @IBOutlet weak var txtInvestmentType: UITextField!
   
    @IBOutlet weak var txtDirection: UITextField!
    @IBOutlet weak var pickerInvestmentType: UIPickerView!
    
    @IBOutlet weak var btnProfitLoss: UISegmentedControl!
    
    @IBOutlet weak var lblTradeEndYear: UILabel!
   
    @IBOutlet weak var stpYear: UIStepper!
    
    @IBOutlet weak var swtIsLongTerm: UISwitch!
    @IBOutlet weak var swtIsShortDirection: UISwitch!
    
    @IBOutlet weak var txtProfitLoss: UITextField!
    
    weak var lotPosition = LotPosition() // TODO: is it used?
    
    var selectedLotPosition : LotPosition?
    
    var directionArray = [ENumDirection.Long.rawValue, ENumDirection.CoveredShort.rawValue, ENumDirection.UnCoveredShort.rawValue]
    var investmentTypeArray =  [ENumInvestmentType.Equity.rawValue, ENumInvestmentType.Dividend.rawValue, ENumInvestmentType.NonQualifiedDividend.rawValue, ENumInvestmentType.Section1256.rawValue]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerInvestmentType.hidden = true
        
        let date = NSDate()
        var dateFormatter = NSDateFormatter()
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear, fromDate: date)
        let year = components.year
        
        stpYear.maximumValue = 2030 // TODO:
        stpYear.stepValue = 1
        
        if (selectedLotPosition != nil)
        {
            println("This is investment edit")
            txtSymbol.text = selectedLotPosition?.SymbolCode
            txtInvestmentType.text = selectedLotPosition?.InvestmentType.rawValue
            txtProfitLoss.text = selectedLotPosition?.RealizedGainLoss.description
            if(selectedLotPosition?.Direction.rawValue == ENumDirection.UnCoveredShort.rawValue)
            {
                swtIsShortDirection.on = true
            }
            else
            {
                swtIsShortDirection.on = false
            }

            lblTradeEndYear.text = selectedLotPosition?.RealizedYear.description
            stpYear.value = lblTradeEndYear.text!.toDouble()!
            swtIsLongTerm.on = selectedLotPosition!.IsLongTerm
            
        }
        else
        {
            lblTradeEndYear.text = year.description
            stpYear.value = Double(year)

        }
        
       
        
    }
    
    
    @IBAction func OntxtProfitLossEditDidEnd(sender: AnyObject) {
    
        /*var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        // formatter.locale = NSLocale.currentLocale() // This is the default
        let txtPrice = formatter.stringFromNumber(txtProfitLoss.text) // "$123.44"
        
        formatter.locale = NSLocale(localeIdentifier: "es_CL")
         txtPrice = formatter.stringFromNumber(price) // $123"
        
      //  formatter.locale = NSLocale(localeIdentifier: "es_ES")
        //formatter.stringFromNumber(price) // "123,44 €"*/
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch(pickerView.tag){
        case 1:
            return investmentTypeArray.count
        case 2:
           
            return directionArray.count

            
        default:
            return 0
            
        
    }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch(pickerView.tag){
        case 1:
           
            return investmentTypeArray[row]
        case 2:
            return directionArray[row]
            
        default:
            return ""
            
        }
        
       
    }
   
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
  {
    switch(pickerView.tag){
    case 1:
        txtInvestmentType.text = investmentTypeArray[row]
        break
        
    default:
        break
        
    }
  }

    @IBAction func OnInvestmentTypeEditBegin(sender: AnyObject)
    {
        if txtInvestmentType.text.isEmpty
        {
            txtInvestmentType.text = ENumInvestmentType.Equity.rawValue
        }
        
        pickerInvestmentType.hidden = false
    }
    
    @IBAction func OnInvestmentTypeEditEnd(sender: AnyObject) {
        pickerInvestmentType.hidden = true
       
    }
   
   
    @IBAction func OnProfitLossValueChanged(sender: AnyObject) {
        if(btnProfitLoss.selectedSegmentIndex==0)
        {
            txtProfitLoss.textColor = UIColor.greenColor()
       //  txtProfitLoss.text = "Profit"
         //   txtProfitLoss.backgroundColor
        }
        else if(btnProfitLoss.selectedSegmentIndex==1)
        {
         txtProfitLoss.textColor = UIColor.redColor()
        }
       // if (sender.btnProfitLoss.)
    }

    @IBAction func stpYearValueChanged(sender: AnyObject) {
        lblTradeEndYear.text = Int(stpYear.value).description
       // if(stpYear.)
    }
    
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool // Invoked immediately prior to 
   {
    
    var alertAssetDesc = UIAlertController(title: "Asset Description", message: "Asset Description is required", preferredStyle: UIAlertControllerStyle.Alert)
    alertAssetDesc.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        println("Handle Cancel Logic here")
    }))
    
    var alertAssetType = UIAlertController(title: "Asset Type", message: "Asset Type is required", preferredStyle: UIAlertControllerStyle.Alert)
    alertAssetType.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        println("Handle Cancel Logic here")
    }))
    
    var alertProfitLoss = UIAlertController(title: "Profit / Loss", message: "Profit / Loss should be numeric", preferredStyle: UIAlertControllerStyle.Alert)
    alertProfitLoss.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        println("Handle Cancel Logic here")
    }))
    

        if (txtSymbol.text.isEmpty)
        {
             presentViewController(alertAssetDesc, animated: true, completion: nil)
            return false
        }
        else if(txtInvestmentType.text.isEmpty)
        {
            presentViewController(alertAssetType, animated: true, completion: nil)
            return false
        }
        else if(txtProfitLoss.text.toDouble() == nil)
        {
            presentViewController(alertProfitLoss, animated: true, completion: nil)
            return false
        }
    
        else
        {
            return true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var lotPosition = LotPosition()
        var errorMessage = String()

        if btnAddInvestment === sender
        {
            
            lotPosition.SymbolCode = txtSymbol.text
            
            
            if (ENumInvestmentType(rawValue: txtInvestmentType.text!) != nil)
            {
                lotPosition.InvestmentType = ENumInvestmentType(rawValue: txtInvestmentType.text)!
            }
            else
            {
                lotPosition.InvestmentType = ENumInvestmentType.Equity
                
            }
            
            if(swtIsShortDirection.on)
            {
                lotPosition.Direction = ENumDirection.UnCoveredShort
            }
            else
            {
                lotPosition.Direction = ENumDirection.Long
            }
            
           
            lotPosition.RealizedGainLoss = txtProfitLoss.text.toDouble()!
            lotPosition.RealizedYear = lblTradeEndYear.text!.toInt()!
            lotPosition.IsLongTerm = swtIsLongTerm.on

            
            
            if (self.selectedLotPosition != nil)
            {
                lotPosition.LotId = selectedLotPosition!.LotId
                CapitalGainController.sharedInstance.UpdateLotPosition(lotPosition)
                CapitalGainController.sharedDBInstance.UpdateInvestment(lotPosition)
            }
            else
            {
                CapitalGainController.sharedInstance.AddLotPosition(lotPosition)
                CapitalGainController.sharedDBInstance.InsertInvestment(lotPosition)
            }
            
            
        }
    }
    
    
}

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NSNumberFormatter().numberFromString(self)?.integerValue
    }
}
