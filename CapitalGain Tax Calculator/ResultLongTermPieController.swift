//
//  ResultPieController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 9/2/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ResultLongTermPieController: UIViewController {

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
           DrawLongTermPieChart()
        }
        
       

    }

    func DrawLongTermPieChart()
    {
        if (_utils.FilingStatusForGraph.Year != 0)
        {
            
           let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
            let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
            
         //   let months = ["15%","30%"]
         ////   let unitsSold = [400,80000]
            
            var lstTaxBracket = TaxOnCapitalGainLossUp.GetTaxHairCut(_utils.FilingStatusForGraph)
            
            
            var longTermTaxBracket = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).first
            //var longTermTaxPercDict = lstTaxBracket.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).first?.FederalTax.dictionary
            
            
          //  setChart(months, values: unitsSold)
           // setPieChart(longTermTaxBracket)
        setLTPieChart(_utils.FilingStatusForGraph.FilingStatusTax)
           
        }
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
       // var a = 10
        //var x :  String
        //x = a.description + "%"
        for item in lstFilingStatusAt
        {
            
            if (item.Term.rawValue == ENumTerm.LongTerm.rawValue)
            {
                index = index + 1
                
                let ltStackedCapitalGain = item.Limit
                let taxEntry = ChartDataEntry(value: ltStackedCapitalGain, xIndex: index)
                let limitTaxAt = item.LimitTaxedAt
                taxPerc.append((limitTaxAt * 100).description + "%")
                taxLimit.append(taxEntry)
                
            }
           
        }
        
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
    
    func setPieChart(taxBracket: TaxBracket){
        var taxLimit: [ChartDataEntry] = []
        var taxPerc : [NSObject] = []
        
        for i in 0..<taxBracket.FederalTax.array.count {
            let keyItem = taxBracket.FederalTax.array[i]
            let taxEntry = ChartDataEntry(value: keyItem, xIndex: i)
            let keyValue = taxBracket.FederalTax.dictionary[keyItem]
            
            taxPerc.append(keyValue!)
            taxLimit.append(taxEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: taxLimit, label: "Tax Slab")
        let pieChartData = PieChartData(xVals: taxPerc, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<taxBracket.FederalTax.array.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            
             let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
    }
    func setChart(dataPoints: [String], values: [Double]) {
       
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        //notifyDataSetChanged()
    }

}
