//
//  ResultPieController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 9/2/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ResultLongTermPieController: UIViewController {

  //  private var _utils = Utils()
    
    @IBOutlet weak var pieChartView: PieChartView!

    private var _lstTaxBracket = [TaxBracket]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        if (CapitalGainController.sharedInstance.GetResultFilingStatus().Year == 0)
        {
            return
        }
        else
        {
           DrawLongTermPieChart()
        }
        
       

    }

    func DrawLongTermPieChart()
    {
        
        let resultFilingStatus = CapitalGainController.sharedInstance.GetResultFilingStatus()
        
        var lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(resultFilingStatus)
        
        var longTermTaxBracket = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).first
        
        setLTPieChart(resultFilingStatus.FilingStatusTax)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLTPieChart(lstFilingStatusAt : [FilingStatusTaxAt])
    {
        var taxLimit: [ChartDataEntry] = []
        var taxPerc = [NSObject]()
        var index : Int = 0
   
        for item in lstFilingStatusAt
        {
            
            if (item.Term.rawValue == ENumTerm.LongTerm.rawValue && item.Limit != 0)
            {
                index = index + 1
                
                let ltStackedCapitalGain = item.Limit
                let taxEntry = ChartDataEntry(value: ltStackedCapitalGain, xIndex: index)
                let limitTaxAt = item.LimitTaxedAt
                taxPerc.append((limitTaxAt * 100).description + "%")
                taxLimit.append(taxEntry)
                
            }
           
        }
        
        if (taxLimit.count == 0)
        {
            pieChartView.clearsContextBeforeDrawing = true
            pieChartView.clear()
        }
        else
        {
            let pieChartDataSet = PieChartDataSet(yVals: taxLimit, label: "Long Term Tax Slab")
            let pieChartData = PieChartData(xVals: taxPerc, dataSet: pieChartDataSet)
            
            pieChartView.data = pieChartData
            
            var colors: [UIColor] = []
            
            for i in 0..<index {
                
                if (i == 0)
                {
                    let color = UIColor.redColor().colorWithAlphaComponent(0.6)
                    colors.append(color)
                }
                else
                {
                    let color = UIColor.blueColor().colorWithAlphaComponent(0.6)
                    colors.append(color)
                }
                
            }
            
            pieChartDataSet.colors = colors
        }
        
    }
    
  

}
