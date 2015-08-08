//
//  TaxViewController - ContainerViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/8/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class TaxViewControllerContainer: UIViewController , UIPickerViewDelegate {

    @IBOutlet weak var pickerYear: UIPickerView!
    
    var yearArray = ["2014", "2013"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return yearArray.count
        
        
    }
  
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return yearArray[row]
    
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
    }
    

}
