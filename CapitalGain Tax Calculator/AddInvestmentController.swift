//
//  AddStockViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/16/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class AddInvestmentController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var btnAddInvestment: UIBarButtonItem!
    
    @IBOutlet weak var txtSymbol: UITextField!
   
    @IBOutlet weak var btnProfitLoss: UISegmentedControl!
    
    @IBOutlet weak var lblTradeEndYear: UILabel!
   
    @IBOutlet weak var stpYear: UIStepper!
    
    @IBOutlet weak var swtIsLongTerm: UISwitch!
    @IBOutlet weak var swtIsShortDirection: UISwitch!
    
    @IBOutlet weak var txtProfitLoss: UITextField!
    
    weak var lotPosition = LotPosition() // TODO: is it used?
    
    var selectedLotPosition : LotPosition?
    
    var utils = Utils()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        addToolBar(self.txtProfitLoss)
        addToolBar(self.txtSymbol)
        
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
            
            txtProfitLoss.text = utils.ConvertStringToCurrency(selectedLotPosition?.RealizedGainLoss.description)
            
            if(selectedLotPosition?.RealizedGainLoss > 0)
            {
                txtProfitLoss.textColor = UIColor.greenColor()
                btnProfitLoss.selectedSegmentIndex = 0
            }
            else
            {
                txtProfitLoss.textColor = UIColor.redColor()
                btnProfitLoss.selectedSegmentIndex = 1
            }
            
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
    
    @IBAction func OntxtProfitLossEditDidBegin(sender: AnyObject) {
        
        if(txtProfitLoss.text != nil)
        {
            txtProfitLoss.text = utils.ConvertCurrencyToString(txtProfitLoss.text)
            
            if(btnProfitLoss.selectedSegmentIndex == 0)
            {
                txtProfitLoss.textColor = UIColor.greenColor()
            }
            else if(btnProfitLoss.selectedSegmentIndex == 1)
            {
                txtProfitLoss.textColor = UIColor.redColor()
                
            }
        }
        
    }
    
    
    @IBAction func OntxtProfitLossEditDidEnd(sender: AnyObject) {
        if(txtProfitLoss.text != nil)
        {
            txtProfitLoss.text = utils.ConvertStringToCurrency(txtProfitLoss.text)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
    @IBAction func OnProfitLossValueChanged(sender: AnyObject) {
        if(btnProfitLoss.selectedSegmentIndex==0)
        {
            txtProfitLoss.textColor = UIColor.greenColor()
        }
        else if(btnProfitLoss.selectedSegmentIndex==1)
        {
         txtProfitLoss.textColor = UIColor.redColor()
        }
       
    }

    @IBAction func stpYearValueChanged(sender: AnyObject) {
        lblTradeEndYear.text = Int(stpYear.value).description
       
    }
    
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool // Invoked immediately prior to 
   {
    
    txtProfitLoss.text = utils.ConvertCurrencyToString(txtProfitLoss.text)
    
    var alertAssetDesc = UIAlertController(title: "Asset Description", message: "Asset Description is required", preferredStyle: UIAlertControllerStyle.Alert)
    alertAssetDesc.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
  
    }))
    
    
    var alertProfitLoss = UIAlertController(title: "Profit / Loss", message: "Profit / Loss should be numeric", preferredStyle: UIAlertControllerStyle.Alert)
    alertProfitLoss.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
  
    }))
   
    var alertProfitNotLessThanZero = UIAlertController(title: "Profit / Loss", message: "Profit cannot be less than Zero", preferredStyle: UIAlertControllerStyle.Alert)
    alertProfitNotLessThanZero.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        
    }))

        if (txtSymbol.text.isEmpty)
        {
             presentViewController(alertAssetDesc, animated: true, completion: nil)
            return false
        }
        else if(txtProfitLoss.text.toDouble() == nil)
        {
            presentViewController(alertProfitLoss, animated: true, completion: nil)
            return false
        }
        else if(txtProfitLoss.text.toDouble() < 0 && btnProfitLoss.selectedSegmentIndex == 0 )
        {
            presentViewController(alertProfitNotLessThanZero, animated: true, completion: nil)
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
 
            if(swtIsShortDirection.on)
            {
                lotPosition.Direction = ENumDirection.UnCoveredShort
            }
            else
            {
                lotPosition.Direction = ENumDirection.Long
            }
            
            if(btnProfitLoss.selectedSegmentIndex == 1 && txtProfitLoss.text.toDouble() > 0)
            {
                lotPosition.RealizedGainLoss = txtProfitLoss.text.toDouble()! * -1
            }
            else
            {
                lotPosition.RealizedGainLoss = txtProfitLoss.text.toDouble()!
            }
           
            
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
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
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
