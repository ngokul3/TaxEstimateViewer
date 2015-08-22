//
//  ResultLabelController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ResultLabelController: UIViewController {

    private var _filingStatus = FilingStatus()
    private var _lstTaxBracket = [TaxBracket]()
    
    var FilingStatusForGraph: FilingStatus {
        get {
             _filingStatus = CapitalGainController.sharedInstance.GetResultFilingStatus()
            return _filingStatus
        }
        set {
            _filingStatus = newValue
        }
    }
    
    var TaxBracketForGraph: [TaxBracket] {
        get {
            return _lstTaxBracket
        }
        set {
            _lstTaxBracket = newValue
        }
    }

    
    @IBOutlet weak var txtAnnualIncome: UITextField!
    @IBOutlet weak var lblShortTermTax: UILabel!

    @IBOutlet weak var test23: UILabel!
    @IBOutlet weak var tes2: UILabel!
    @IBOutlet weak var tst1: UILabel!
    @IBOutlet weak var lblTotalTax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let x = 10
  //      lblShortTermTax.text = "This is a short Term invesment"
        // Do any additional setup after loading the view.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func ShowLongTermShortTermLabel()
    {
        if (self.FilingStatusForGraph.Year != 0)
        {
            self.TaxBracketForGraph = TaxOnCapitalGainLossUp.GetTaxHairCut(self.FilingStatusForGraph)
            
            self.txtAnnualIncome.text = FilingStatusForGraph.CurrentTaxableIncome.description
       
        }
    }


}
