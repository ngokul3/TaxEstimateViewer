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
    
    @IBOutlet weak var txtAnnualIncome: UITextField!
    
    @IBOutlet weak var txtLTGain: UITextField!
    
    @IBOutlet weak var txtSTGain: UITextField!
    
    @IBOutlet weak var txtTaxOnLT: UITextField!
    
    @IBOutlet weak var txtTaxOnST: UITextField!
    
    @IBOutlet weak var txtTotalTax: UITextField!
    
   // toViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
   // fromViewController.willMoveToParentViewController(nil)
    
    var FilingStatusForGraph: FilingStatus {
        get {
             _filingStatus = CapitalGainController.sharedInstance.GetResultFilingStatus()
            return _filingStatus
        }
        set {
            _filingStatus = newValue
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()

    //let pageViewController = TaxPageController()
  //  let thisWidth = pageViewController.view.frame.size. width
    //let thisHeight = pageViewController.view.frame.size.height
        
       self.view.frame = CGRect(x: 0, y: 0, width: 375, height: 243)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func labelTest(thisWidth: CGFloat, thisHeight: CGFloat)
    {
        self.view.frame = CGRect(x: 0, y: 0, width: thisWidth, height: thisHeight)
    }
    func ShowLongTermShortTermLabel()
    {
        if (self.FilingStatusForGraph.Year != 0)
        {
            self.txtAnnualIncome.text = FilingStatusForGraph.CurrentTaxableIncome.description
            self.txtLTGain.text = FilingStatusForGraph.FilingStatusTax.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).map{ return $0.Limit }.reduce(0) { return $0 + $1 }.description
            
            self.txtSTGain.text = FilingStatusForGraph.FilingStatusTax.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).map{ return $0.Limit }.reduce(0) { return $0 + $1 }.description
       
            self.txtTaxOnLT.text = FilingStatusForGraph.TaxOnLTCapitalGain.description
            self.txtTaxOnST.text = FilingStatusForGraph.TaxOnSTCapitalGain.description
            self.txtTotalTax.text = (FilingStatusForGraph.TaxOnLTCapitalGain + FilingStatusForGraph.TaxOnSTCapitalGain).description
            
       
        }
    }


}
