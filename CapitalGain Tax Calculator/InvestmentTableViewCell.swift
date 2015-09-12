//
//  InvestmentTableViewCell.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/26/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class InvestmentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInvesmentName: UILabel!
    
    @IBOutlet weak var lblProfitLoss: UILabel!
    
    @IBOutlet weak var imgLTST: UIImageView!
    
    @IBOutlet weak var img360: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ImageForLTST(direction: ENumDirection ) -> UIImage!
    {
        var assetName = String()
        
        if (direction.rawValue == ENumDirection.Long.rawValue)
        {
            assetName = "Short_No"
        }
        else if (direction.rawValue == ENumDirection.UnCoveredShort.rawValue)
        {
            assetName = "Short_Yes"
            
        }
        return  UIImage(named: (assetName))
    }
    
    func ImageFor365(IsLongTerm: Bool ) -> UIImage!
    {
        var assetName = String()
        
        if (IsLongTerm)
        {
            assetName = "365"
        }
        else if (IsLongTerm == false)
        {
            assetName = "365-No"
            
        }
        return  UIImage(named: (assetName))
    }
}
