//
//  TabBarViewController.swift
//  Tumblr
//
//  Created by Kyle DeHovitz on 5/28/15.
//  Copyright (c) 2015 Kyle DeHovitz. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var contentView: UIView!
    
    var homeViewController: HomeViewController!
    var searchViewController: SearchViewController!
    var composeViewController: ComposeViewController!
    var accountViewController: AccountViewController!
    var trendingViewController: TrendingViewController!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var trendingButton: UIButton!
    
    var isPresenting: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        searchViewController = storyboard.instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
        accountViewController = storyboard.instantiateViewControllerWithIdentifier("AccountViewController") as! AccountViewController
        trendingViewController = storyboard.instantiateViewControllerWithIdentifier("TrendingViewController") as! TrendingViewController
        
        stateChange("home")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTabPress(sender: AnyObject) {
            
            if homeButton.touchInside == true {
                stateChange("home")
            }
            else if searchButton.touchInside == true{
                stateChange("search")
            }
            else if composeButton.touchInside == true{
                stateChange("compose")
            }
            else if accountButton.touchInside == true{
                stateChange("account")
            }
            else if trendingButton.touchInside == true{
                stateChange("trending")
            }
            
    }
    
    
//    Declare Parent-Child relationship
    func displayContentController(content: UIViewController) {
        addChildViewController(content)
        contentView.addSubview(content.view)
        content.didMoveToParentViewController(self)
    }
    
    func hideContentController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    
//    Hide/Show Views and Buttons based on Tab Bar Navigation
    func stateChange(state: String) {
        
        if state == "home" {
            
            //homeButton selected
            homeButton.selected = true
            searchButton.selected = false
            composeButton.selected = false
            accountButton.selected = false
            trendingButton.selected = false
            
            //homeView displayed
            displayContentController(homeViewController)
            hideContentController(searchViewController)
            hideContentController(accountViewController)
            hideContentController(trendingViewController)
            
        }
            
        else if state == "search"
        {
            
            //searchButton selected
            homeButton.selected = false
            searchButton.selected = true
            composeButton.selected = false
            accountButton.selected = false
            trendingButton.selected = false
            
            //searchView displayed
            hideContentController(homeViewController)
            displayContentController(searchViewController)
            hideContentController(accountViewController)
            hideContentController(trendingViewController)
            
        }
            
        else if state == "compose"
        {
            //composeButton selected
            homeButton.selected = false
            searchButton.selected = false
            composeButton.selected = true
            accountButton.selected = false
            trendingButton.selected = false
            
            /*composeView displayed
            hideContentController(homeViewController)
            hideContentController(searchViewController)
            displayContentController(composeViewController)
            hideContentController(accountViewController)
            hideContentController(trendingViewController)*/
            
        }
            
        else if state == "account"
        {
            //accountButton selected
            homeButton.selected = false
            searchButton.selected = false
            composeButton.selected = false
            accountButton.selected = true
            trendingButton.selected = false
            
            //accountView displayed
            hideContentController(homeViewController)
            hideContentController(searchViewController)
            displayContentController(accountViewController)
            hideContentController(trendingViewController)
            
        }
        else if state == "trending"{
            
            //trendingButton selected
            homeButton.selected = false
            searchButton.selected = false
            composeButton.selected = false
            accountButton.selected = false
            trendingButton.selected = true
            
            //trendingView displayed
            hideContentController(homeViewController)
            hideContentController(searchViewController)
            hideContentController(accountViewController)
            displayContentController(trendingViewController)
        }
        
    }
    
    
//    Composer Segue is presented as a modal
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as! UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
//    Allow a custom transition when animated in
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
//    Allow a custom transition management when animated out
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
//    Timing for transition management
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
//    Transition animation occurs
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
//            Add a VC as a subView to the containerView
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }



    


    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
