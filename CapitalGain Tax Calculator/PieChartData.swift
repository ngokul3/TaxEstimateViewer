//
//  PieChartDataSet.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/31/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation


public class PieChartData: ChartData
{
    public override init()
    {
        super.init();
    }
    
    public override init(xVals: [String?]?, dataSets: [ChartDataSet]?)
    {
        super.init(xVals: xVals, dataSets: dataSets)
    }

    public override init(xVals: [NSObject]?, dataSets: [ChartDataSet]?)
    {
        super.init(xVals: xVals, dataSets: dataSets)
    }

    var dataSet: PieChartDataSet?
    {
        get
        {
            return dataSets.count > 0 ? dataSets[0] as? PieChartDataSet : nil;
        }
        set
        {
            if (newValue != nil)
            {
                dataSets = [newValue!];
            }
            else
            {
                dataSets = [];
            }
        }
    }
    
    public override func getDataSetByIndex(index: Int) -> ChartDataSet?
    {
        if (index != 0)
        {
            return nil;
        }
        return super.getDataSetByIndex(index);
    }
    
    public override func getDataSetByLabel(label: String, ignorecase: Bool) -> ChartDataSet?
    {
        if (dataSets.count == 0 || dataSets[0].label == nil)
        {
            return nil;
        }
        
        if (ignorecase)
        {
            if (label.caseInsensitiveCompare(dataSets[0].label!) == NSComparisonResult.OrderedSame)
            {
                return dataSets[0];
            }
        }
        else
        {
            if (label == dataSets[0].label)
            {
                return dataSets[0];
            }
        }
        return nil;
    }
}
