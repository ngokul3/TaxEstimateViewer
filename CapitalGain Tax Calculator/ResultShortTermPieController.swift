//
//  ResultShortTermPieController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 9/2/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ResultShortTermPieController: UIViewController {

    private var _utils = Utils()
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    private var _lstTaxBracket = [TaxBracket]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (_utils.FilingStatusForGraph.Year == 0)
        {
            return
        }
        else
        {
            DrawShortTermPieChart()
        }
    }

    func DrawShortTermPieChart()
    {
        if (_utils.FilingStatusForGraph.Year != 0)
        {
            
            
            var lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(_utils.FilingStatusForGraph)
            
            
            var shortTermTaxBracket = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).first
            
            
             setSTPieChart(_utils.FilingStatusForGraph.FilingStatusTax)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setSTPieChart(lstFilingStatusAt : [FilingStatusTaxAt])
    {
        var taxLimit: [ChartDataEntry] = []
        var taxPerc = [NSObject]()
        var index : Int = 0
         for item in lstFilingStatusAt
        {
            
            if (item.Term.rawValue == ENumTerm.ShortTerm.rawValue)
            {
                index = index + 1
                
                let ltStackedCapitalGain = item.Limit
                let taxEntry = ChartDataEntry(value: ltStackedCapitalGain, xIndex: index)
                let limitTaxAt = item.LimitTaxedAt
                taxPerc.append((limitTaxAt * 100).description + "%")
                taxLimit.append(taxEntry)
                
            }
            
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: taxLimit, label: "Short Term Tax Slab")
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
