//
//  ContainerMultiResultController.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 8/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit

class ContainerMultiResultController: UIViewController {

    var currentSegueIdentifier : String = "ShowResulLabel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegueWithIdentifier(self.currentSegueIdentifier, sender: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
   override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
          if(segue.identifier == "ShowResulLabel")
            {
                if(self.childViewControllers.count > 0)
                {
                    self.SwapFromViewController(self.childViewControllers[0] as! UIViewController, toViewController: segue.destinationViewController as! UIViewController)
                    
                }
                else
                {
                    self.addChildViewController(segue.destinationViewController as! UIViewController)
                    segue.destinationViewController.view!!.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)

                    self.view.addSubview((segue.destinationViewController as! UIViewController).view)
                    segue.destinationViewController.didMoveToParentViewController(self)
                }
                
            }
          
            else if(segue.identifier == "ShowLongTermBarGraph")
            {
            
            }
           /* else if ([segue.identifier isEqualToString:SegueIdentifierSecond])
            {
                [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
            }
            */
            
    }
    
    func SwapFromViewController(fromViewController: UIViewController ,toViewController: UIViewController )
    {
        toViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
        fromViewController.willMoveToParentViewController(nil)
        
        self.addChildViewController(toViewController)
        self.transitionFromViewController(fromViewController, toViewController: toViewController, duration: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: nil, completion: nil)
        
        fromViewController.removeFromParentViewController()
        toViewController.didMoveToParentViewController(self)
    }

   
  /*  - (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
    {
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
    [fromViewController removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
    }];
    }
 */
    
    func SwapViewControllers()
    {
        self.currentSegueIdentifier = "ShowResulLabel"
        self.performSegueWithIdentifier(self.currentSegueIdentifier, sender: nil)
    }
  

}
