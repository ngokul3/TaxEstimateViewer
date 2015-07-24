//
//  AddStockViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/16/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class AddInvestmentController: UIViewController {
    
    @IBOutlet weak var btnAddInvestment: UIBarButtonItem!
    
    @IBOutlet weak var txtSymbol: UITextField!
    
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtCost: UITextField!
    weak var lotPosition = LotPosition()

    
    @IBAction func AddInvestment(sender: AnyObject) {
        
        var investArray = NSMutableArray()
        
        investArray = CapitalGainController.sharedInstance.GetInvestments()
        
        let itemCount = investArray.count
        
        let lotPosition = LotPosition(lotId: itemCount+1, symbolCode: txtSymbol.text,symbolDesc: txtSymbol.text)
        
        
        CapitalGainController.sharedInstance.AddInvestment(lotPosition)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
