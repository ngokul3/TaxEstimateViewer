//
//  ViewController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/14/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class InvestmentDetailController: UIViewController{
@IBOutlet weak var nameLabel: UILabel!
    

    override func viewDidLoad() {
         refreshUI()
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var lotPosition: LotPosition! {
        didSet (newStock) {
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        
        
        nameLabel?.text = lotPosition.GetStockDetail()
        /*descriptionLabel?.text = monster.description
        iconImageView?.image = UIImage(named: monster.iconName)
        weaponImageView?.image = monster.weaponImage()*/
    }
   

}


