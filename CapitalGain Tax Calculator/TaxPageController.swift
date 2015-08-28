//
//  TaxPageController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/16/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class TaxPageController: UIPageViewController, UIPageViewControllerDataSource {

    private var _controllerEnum: ControllerEnum = ControllerEnum()
    private var _dict: [UIViewController: ControllerEnum] = [:]
    
    private var _filingStatus = FilingStatus()
    private var _lstTaxBracket = [TaxBracket]()
    private var _page1 = ResultLabelController()
    private var _page2 = ResultGraphController()
    
    var FilingStatusForGraph: FilingStatus {
        get {
            return _filingStatus
        }
        set {
            _filingStatus = newValue
        }
    }
    
    var TaxBracketForGraph: [TaxBracket] {
        get {
            return _lstTaxBracket
        }
        set {
            _lstTaxBracket = newValue
        }
    }

    
    private var myViewControllers = NSArray()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        self.dataSource = self
        
      //  RefreshTaxViewPages()
        
        _page1 = self.storyboard?.instantiateViewControllerWithIdentifier("ResultLabelID") as! ResultLabelController
        _page2 = self.storyboard?.instantiateViewControllerWithIdentifier("ResultLongTermGraphID") as! ResultGraphController
        
        myViewControllers = [_page1, _page2]
        
        self.setViewControllers([_page2], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
   
        self.setViewControllers([_page1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        for uiView in self.view.subviews
        {
            if (uiView.isKindOfClass(UIPageControl))
            {
                let pageControl = uiView as! UIPageControl
                pageControl.pageIndicatorTintColor = UIColor.redColor()
                
            }
        }

        NSLog("loaded!");
        
        
     //   setViewControllers([getController(_controllerEnum)!], direction: .Forward, animated: false, completion: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RefreshTaxViewPages()
    {
        _page1.labelTest(self.view.frame.size.width, thisHeight: self.view.frame.size.height)
       _page1.ShowLongTermShortTermLabel()
        _page2.DrawLongTermShortTermGraph()
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
       // return _controllerEnum.rawValue
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return myViewControllers.count
        //return ControllerEnum.GetCount()
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController
    {
        return myViewControllers[index] as! UIViewController;
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var currentIndex : NSInteger
        currentIndex = myViewControllers.indexOfObject(viewController)
        
        if (currentIndex == 0)
        {
            return nil;
        }
        
        currentIndex = currentIndex - 1
        
        currentIndex = currentIndex % (myViewControllers.count)
        return myViewControllers.objectAtIndex(currentIndex) as? UIViewController
        //return getController(_dict[viewController]!.prevIndex())
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
      
        var currentIndex : NSInteger
        currentIndex = myViewControllers.indexOfObject(viewController)
        
        if (currentIndex == myViewControllers.count - 1)
        {
            return nil;
        }
        
        currentIndex = currentIndex + 1
        
        currentIndex = currentIndex % (myViewControllers.count)
        return myViewControllers.objectAtIndex(currentIndex) as? UIViewController
        
         // return getController(_dict[viewController]!.nextIndex())
    }
    
    private func getController(value: ControllerEnum) -> UIViewController? {
        var vc: UIViewController?
        switch value {
        case .ResultLabel:
            let resultLabelController = ResultLabelController()
            resultLabelController.ShowLongTermShortTermLabel()
            vc = resultLabelController
         //   vc!.view.backgroundColor = UIColor.redColor()
            
        case .Center:
            vc = UIViewController()
            vc!.view.backgroundColor = UIColor.greenColor()
            
        case .Debts:
            vc = UIViewController()
            vc!.view.backgroundColor = UIColor.blueColor()
            
        default: return nil
        }
        // store relative enum to view controller
        _dict[vc!] = value
        return vc!
    }

}

private enum ControllerEnum: Int {
    static let allValues = [ResultLabel, Center, Debts]
    
    case Nil = -1, ResultLabel, Center, Debts
    
    init() {
        self = .ResultLabel
    }
    
    func prevIndex() -> ControllerEnum {
        return ControllerEnum(rawValue: rawValue-1)!
    }
    
    func nextIndex() -> ControllerEnum {
        var value = rawValue+1
        if value > ControllerEnum.allValues.count-1 { value = Nil.rawValue }
        return ControllerEnum(rawValue: value)!
    }
    
    static func GetCount() -> Int
    {
        return allValues.count
    }
    
}