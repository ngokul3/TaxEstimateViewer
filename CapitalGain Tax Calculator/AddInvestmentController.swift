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
    
        @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtCost: UITextField!
    weak var lotPosition = LotPosition()
    var directionArray = ["Long","Short","CoveredShort"]
    var investmentTypeArray = ["Equity","Regular Income / Dividend","Section 1256"]
    
    @IBAction func AddInvestment(sender: AnyObject) {
        
        var investArray = NSMutableArray()
        
        investArray = CapitalGainController.sharedInstance.GetInvestments()
        
        let itemCount = investArray.count
        
        let lotPosition = LotPosition(lotId: itemCount+1, symbolCode: txtSymbol.text,symbolDesc: txtSymbol.text)
        
        
        CapitalGainController.sharedInstance.AddInvestment(lotPosition)
        
    }
    
 
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerInvestmentType.hidden = true
        pickerDirection.hidden = true

        // Do any additional setup after loading the view.
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
    
}
