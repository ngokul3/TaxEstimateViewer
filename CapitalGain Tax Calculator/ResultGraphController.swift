//
//  ResultsLongTermGraphController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/16/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit


class ResultGraphController: UIViewController {

  //  private var _utils = Utils()

    
    @IBOutlet weak var graphPieChartView: PieChartView!
    
    private var chart: Chart?
    
    private let dirSelectorHeight: CGFloat = 50
    private let CONST_GRAPH_INTERVAL: Double = 5
    
    private func barsChart(horizontal horizontal: Bool,stackedLongTermIncomeLevel : [Double], stackedShortTermIncomeLevel : [Double] ) -> Chart {
        
        let resultFilingStatus = CapitalGainController.sharedInstance.GetResultFilingStatus()
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let currentIncome = resultFilingStatus.CurrentTaxableIncome

        let groupsData: [(title: String, bars: [(start: CGFloat, quantities: [Double])])] = [
            ("Long Term", [
                (CGFloat(currentIncome),
                    stackedLongTermIncomeLevel
                )
                ]),
            ("Short Term", [
                (CGFloat(currentIncome),
                    stackedShortTermIncomeLevel
                )
                ])
        ]

     
        /**/
  
        let frameColors = [UIColor.redColor().colorWithAlphaComponent(0.6), UIColor.blueColor().colorWithAlphaComponent(0.6), UIColor.greenColor().colorWithAlphaComponent(0.6)]
        
       /* let groups: [ChartPointsBarGroup<ChartStackedBarModel>] = Array(enumerate(groupsData)).map {index, entry in
            let constant = ChartAxisValueFloat(CGFloat(index))
            let bars: [ChartStackedBarModel] = Array(enumerate(entry.bars)).map {index, bars in
                let items = Array(enumerate(bars.quantities)).map {index, quantity in
                    ChartStackedBarItemModel(quantity, frameColors[index])
                }
                return ChartStackedBarModel(constant: constant, start: ChartAxisValueFloat(bars.start), items: items)
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }*/ //Convert
        
        
        
        let groups: [ChartPointsBarGroup<ChartStackedBarModel>] = groupsData.enumerate().map {index, entry in
            let constant = ChartAxisValueFloat(CGFloat(index))
            let bars: [ChartStackedBarModel] = entry.bars.enumerate().map {index, bars in
                let items = bars.quantities.enumerate().map {index, quantity in
                    ChartStackedBarItemModel(quantity, frameColors[index])
                }
                return ChartStackedBarModel(constant: constant, start: ChartAxisValueFloat(bars.start), items: items)
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }
        
       

        /* */
       // var xTaxBracket = [ChartAxisValueFloat]()
        
        
       // let incomeItem =  ChartAxisValueFloat(CGFloat(currentIncome),labelSettings: labelSettings)
        
        let lstFilingStatusTax = resultFilingStatus.FilingStatusTax
  
        let LTTaxTotal = lstFilingStatusTax.filter({m in m.Term.rawValue == ENumTerm.LongTerm.rawValue}).map{ return $0.Limit}.reduce(0) { return $0 + $1 }
    
        let STTaxTotal = lstFilingStatusTax.filter({m in m.Term.rawValue == ENumTerm.ShortTerm.rawValue}).map{ return $0.Limit}.reduce(0) { return $0 + $1 }

        var maxTermCapitalGain : Double = Double(LTTaxTotal > STTaxTotal ? LTTaxTotal : STTaxTotal)
        
        if maxTermCapitalGain < 0
        {
            maxTermCapitalGain = 0
        }
        else if(maxTermCapitalGain > 0 && maxTermCapitalGain < CONST_GRAPH_INTERVAL)
        {
            maxTermCapitalGain = maxTermCapitalGain + CONST_GRAPH_INTERVAL
        }
        
        let interval = round(((currentIncome + maxTermCapitalGain) - currentIncome) / CONST_GRAPH_INTERVAL)
        
        var axisValues1 = [ChartAxisValue]()
        var axisValues2 = [ChartAxisValue]()
        
      
           /*  (axisValues1, axisValues2) = (
                Array(stride(from: CGFloat(currentIncome), through: CGFloat(currentIncome + maxTermCapitalGain), by: CGFloat(interval))).map {ChartAxisValueFloat($0, labelSettings: labelSettings)},
                [ChartAxisValueString(order: -1)] +
                    Array(enumerate(groupsData)).map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                    [ChartAxisValueString(order: groupsData.count)]
                )*/
        
        
        (axisValues1, axisValues2) = (
             (CGFloat(currentIncome)).stride(through: CGFloat(currentIncome + maxTermCapitalGain), by: CGFloat(interval)).map {ChartAxisValueFloat($0, labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                 groupsData.enumerate().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings:
                    labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )
        
   /*     let (axisValues1, axisValues2): ([ChartAxisValue], [ChartAxisValue]) = (
            (-60).stride(through: 100, by: 20).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                groupsData.enumerate().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )*/
        
                
    
      
        
        /* */
        
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
      
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Term", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Base Income + Capital Gain", settings: labelSettings.defaultVertical()))
        //let frame = ExamplesDefaults.chartFrame(self.view.bounds)
        
        let chartFrame = self.chart?.frame ?? CGRectMake(0,0,375,243)
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let groupsLayer = ChartGroupedStackedBarsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, groups: groups, horizontal: horizontal, barSpacing: 2, groupSpacing: 30, animDuration: 0.5)
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, axis: horizontal ? .X : .Y, settings: settings)
        
        let dummyZeroChartPoint = ChartPoint(x: ChartAxisValueFloat(0), y: ChartAxisValueFloat(0))

        let zeroGuidelineLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: [dummyZeroChartPoint], viewGenerator: {(chartPointModel, layer, chart) -> UIView? in
            let width: CGFloat = 2

         
            let viewFrame: CGRect = {
                if horizontal {
                    return CGRectMake(chartPointModel.screenLoc.x - width / 2, innerFrame.origin.y, width, innerFrame.size.height)
                } else {
                    return CGRectMake(innerFrame.origin.x, chartPointModel.screenLoc.y - width / 2, innerFrame.size.width, width)
                }
                
               
                }()
            
            let v = UIView(frame: viewFrame)
            v.backgroundColor = UIColor.blackColor()
            return v
        })
        
        return Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                groupsLayer,
                zeroGuidelineLayer
            ]
        )
    }
    
    
    private func showChart(horizontal horizontal: Bool) {
        self.chart?.clearView()
        
        var stackedLongTermIncomeLevel = [Double]()
        var stackedShortTermIncomeLevel = [Double]()
        
        let resultFilingStatus = CapitalGainController.sharedInstance.GetResultFilingStatus()
        
        for item in resultFilingStatus.FilingStatusTax
        {
            
            if (item.Term.rawValue == ENumTerm.LongTerm.rawValue)
            {
                let ltStackedCapitalGain = item.Limit
                stackedLongTermIncomeLevel.append(ltStackedCapitalGain)
            }
            else if(item.Term.rawValue == ENumTerm.ShortTerm.rawValue)
            {
                let stStackedCapitalGain = item.Limit
                stackedShortTermIncomeLevel.append(stStackedCapitalGain)
            }
        }
        
        if(stackedLongTermIncomeLevel.count == 0 && stackedShortTermIncomeLevel.count == 0)
        {
            self.chart?.clearView()
            graphPieChartView.hidden = false
        }
        else
        {
            let chart = self.barsChart(horizontal: horizontal, stackedLongTermIncomeLevel: stackedLongTermIncomeLevel,stackedShortTermIncomeLevel : stackedShortTermIncomeLevel )
            
            self.view.addSubview(chart.view)
            self.chart = chart
        }
    }
    
    override func viewDidLoad() {
      if (CapitalGainController.sharedInstance.GetResultFilingStatus().Year == 0)
      {
        return
      }
      else
      {
        DrawLongTermShortTermGraph()
      }
    }
    
    func DrawLongTermShortTermGraph()
    {
        if (CapitalGainController.sharedInstance.GetResultFilingStatus().Year != 0)
        {
            graphPieChartView.hidden = true
            self.showChart(horizontal: false)
     
           /* if let chart = self.chart {
                
                //      let dirSelector = DirSelector(frame: CGRectMake(0, chart.frame.origin.y + chart.frame.size.height, self.view.frame.size.width, self.dirSelectorHeight), controller: self)
                
              //  let dirSelector = DirSelector(frame: CGRectMake(0,0,375,243), controller: self)
                
              //  self.view.addSubview(dirSelector)
            }*/
        }
        else
        {
            self.chart?.clearView()
            graphPieChartView.hidden = false
            
        }
    }
    
    class DirSelector: UIView {
        
        let horizontal: UIButton
        let vertical: UIButton
        
        weak var controller: ResultGraphController?
        
        private let buttonDirs: [UIButton : Bool]
        
        init(frame: CGRect, controller: ResultGraphController) {
            
            self.controller = controller
            
            self.horizontal = UIButton()
            self.horizontal.setTitle("Horizontal", forState: .Normal)
            self.vertical = UIButton()
            self.vertical.setTitle("Vertical", forState: .Normal)
            
            self.buttonDirs = [self.horizontal : true, self.vertical : false]
            
            super.init(frame: frame)
            
            self.addSubview(self.horizontal)
            self.addSubview(self.vertical)
            
            for button in [self.horizontal, self.vertical] {
                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
                button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            }
        }
        
        func buttonTapped(sender: UIButton) {
            let horizontal = sender == self.horizontal ? true : false
            controller?.showChart(horizontal: horizontal)
        }
        
        override func didMoveToSuperview() {
            let views = [self.horizontal, self.vertical]
            for v in views {
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let namedViews = views.enumerate().map{index, view in
                ("v\(index)", view)
            }
            
            let viewsDict = namedViews.reduce(Dictionary<String, UIView>()) {(var u, tuple) in
                u[tuple.0] = tuple.1
                return u
            }
            
            let buttonsSpace: CGFloat = Env.iPad ? 20 : 10
            
            let hConstraintStr = namedViews.reduce("H:|") {str, tuple in
                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
            }
            
            let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraintsWithVisualFormat("V:|[\($0.0)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)}
            
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(hConstraintStr, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)
                + vConstraits)
        }

        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
