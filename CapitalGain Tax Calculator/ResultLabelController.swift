//
//  ResultLabelController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ResultLabelController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
