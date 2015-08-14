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
    
    @IBOutlet weak var pickerDirection: UIPickerView!
    
    @IBOutlet weak var btnProfitLoss: UISegmentedControl!
    
    @IBOutlet weak var lblTradeEndYear: UILabel!
   
    @IBOutlet weak var stpYear: UIStepper!
    
    @IBOutlet weak var txtProfitLoss: UITextField!
    
     weak var lotPosition = LotPosition() // TODO: is it used?
    
    var selectedLotPosition : LotPosition?
    
    var directionArray = [ENumDirection.Long.rawValue, ENumDirection.CoveredShort.rawValue, ENumDirection.UnCoveredShort.rawValue]
    var investmentTypeArray = [ENumInvestmentType.Equity.rawValue, ENumInvestmentType.Dividend.rawValue, ENumInvestmentType.Section1256.rawValue]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerInvestmentType.hidden = true
        pickerDirection.hidden = true
        
        let date = NSDate()
        var dateFormatter = NSDateFormatter()
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear, fromDate: date)
        let year = components.year
        
        lblTradeEndYear.text = year.description
        stpYear.value = Double(year)
        
        stpYear.maximumValue = 2030 // TODO:
        stpYear.stepValue = 1
        
        if (selectedLotPosition != nil)
        {
            println("This is investment edit")
            txtSymbol.text = selectedLotPosition?.SymbolCode
            txtInvestmentType.text = selectedLotPosition?.InvestmentType.rawValue
            txtProfitLoss.text = selectedLotPosition?.RealizedGainLoss.description
            txtDirection.text = selectedLotPosition?.Direction.rawValue
            lblTradeEndYear.text = selectedLotPosition?.RealizedYear.description
            //TODO IsLongTerm
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
    
    
    @IBAction func AddInvestment(sender: AnyObject) {
        
        
        // NOT USED : TODO
     /*    let itemCount = CapitalGainController.sharedInstance.GetLotPositions().count
        let lotPosition = LotPosition()
        lotPosition.LotId = itemCount + 1
        lotPosition.SymbolCode = txtSymbol.text
        lotPosition.InvestmentType = ENumInvestmentType(rawValue: txtInvestmentType.text)!
        lotPosition.Direction = ENumDirection( rawValue : txtDirection.text)!
        lotPosition.RealizedGainLoss = txtProfitLoss.text.toDouble()!
        lotPosition.RealizedYear = lblTradeEndYear.text!.toInt()!
        lotPosition.IsLongTerm = true //TODO
        
        
       CapitalGainController.sharedInstance.AddInvestment(lotPosition)
        
        var test = CapitalGainController.sharedDBInstance.InsertInvestment(lotPosition)*/
        
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
        
    case 2:
        txtDirection.text = directionArray[row]
        break
    default:
        break
        
    }
  }

    @IBAction func OnInvestmentTypeEditBegin(sender: AnyObject) {
        
        pickerInvestmentType.hidden = false
    }
    
    @IBAction func OnInvestmentTypeEditEnd(sender: AnyObject) {
        pickerInvestmentType.hidden = true
       
    }
   
    @IBAction func OnDirectionEditBegin(sender: AnyObject) {
        pickerDirection.hidden = false
    }
    @IBAction func OnDirectionEditEnd(sender: AnyObject) {
        pickerDirection.hidden = true
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if btnAddInvestment === sender
        {
            if (self.selectedLotPosition == nil)
            {
                let itemCount = CapitalGainController.sharedInstance.GetLotPositions().count
                let lotPosition = LotPosition()
             //   lotPosition.LotId = itemCount + 1
                lotPosition.SymbolCode = txtSymbol.text
                lotPosition.InvestmentType = ENumInvestmentType(rawValue: txtInvestmentType.text)!
                lotPosition.Direction = ENumDirection( rawValue : txtDirection.text)!
                lotPosition.RealizedGainLoss = txtProfitLoss.text.toDouble()!
                lotPosition.RealizedYear = lblTradeEndYear.text!.toInt()!
                lotPosition.IsLongTerm = true //TODO
            
                CapitalGainController.sharedInstance.AddLotPosition(lotPosition)
                var test = CapitalGainController.sharedDBInstance.InsertInvestment(lotPosition)
            }
            
            else if (self.selectedLotPosition != nil)
            {
                let lotPosition = LotPosition()
                lotPosition.LotId = selectedLotPosition!.LotId
                lotPosition.SymbolCode = txtSymbol.text
                lotPosition.InvestmentType = ENumInvestmentType(rawValue: txtInvestmentType.text)!
                lotPosition.Direction = ENumDirection( rawValue : txtDirection.text)!
                lotPosition.RealizedGainLoss = txtProfitLoss.text.toDouble()! //ToDO
                lotPosition.RealizedYear = lblTradeEndYear.text!.toInt()! //TODO
                lotPosition.IsLongTerm = true //TODO
                
                CapitalGainController.sharedInstance.UpdateLotPosition(lotPosition)
                var test = CapitalGainController.sharedDBInstance.UpdateInvestment(lotPosition)
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
