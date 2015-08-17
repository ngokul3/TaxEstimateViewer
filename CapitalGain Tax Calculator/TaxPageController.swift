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
    
    private var myViewControllers = NSArray()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        self.dataSource = self
        
        let page1 = self.storyboard?.instantiateViewControllerWithIdentifier("ResultLabelID") as! UIViewController
        let page2 = self.storyboard?.instantiateViewControllerWithIdentifier("ResultLongTermGraphID") as! UIViewController
        
        myViewControllers = [page1, page2]
        
 
        self.setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        NSLog("loaded!");
        
        
     //   setViewControllers([getController(_controllerEnum)!], direction: .Forward, animated: false, completion: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
       // return _controllerEnum.rawValue
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return myViewControllers.count
       
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController
    {
        return myViewControllers[index] as! UIViewController;
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var currentIndex : NSInteger
        currentIndex = myViewControllers.indexOfObject(viewController)
        
        currentIndex = currentIndex - 1
        currentIndex = currentIndex % (myViewControllers.count)
        return myViewControllers.objectAtIndex(currentIndex) as? UIViewController
       // return getController(_dict[viewController]!.prevIndex())
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
      
        var currentIndex : NSInteger
        currentIndex = myViewControllers.indexOfObject(viewController)
        currentIndex = currentIndex + 1
        currentIndex = currentIndex % (myViewControllers.count)
        return myViewControllers.objectAtIndex(currentIndex) as? UIViewController
        
        //  return getController(_dict[viewController]!.nextIndex())
    }
    
    private func getController(value: ControllerEnum) -> UIViewController? {
        var vc: UIViewController?
        switch value {
        case .ResultLabel:
            vc = ResultLabelController()
            vc!.view.backgroundColor = UIColor.redColor()
            
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
        self = .Center
    }
    
    func prevIndex() -> ControllerEnum {
        return ControllerEnum(rawValue: rawValue-1)!
    }
    
    func nextIndex() -> ControllerEnum {
        var value = rawValue+1
        if value > ControllerEnum.allValues.count-1 { value = Nil.rawValue }
        return ControllerEnum(rawValue: value)!
    }
}