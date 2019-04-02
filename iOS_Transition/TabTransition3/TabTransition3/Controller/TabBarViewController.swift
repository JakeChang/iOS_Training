//
//  TabBarViewController.swift
//  TabTransition3
//
//  Created by jake on 2019/1/22.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        delegate = self
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ScrollingTransitionAnimator(tabBarController: tabBarController, lastIndex: tabBarController.selectedIndex)
    }
}

class ScrollingTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    weak var transitionContext: UIViewControllerContextTransitioning?
    var tabBarController: UITabBarController!
    var lastIndex = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    init(tabBarController: UITabBarController, lastIndex: Int) {
        self.tabBarController = tabBarController
        self.lastIndex = lastIndex
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        containerView.addSubview(toViewController!.view)
        
        var viewWidth = toViewController!.view.bounds.width
        
        if tabBarController.selectedIndex < lastIndex {
            viewWidth = -viewWidth
        }
        
        let toViewOriginTrans = toViewController?.view.transform
        let toViewTransFrom = toViewOriginTrans?.translatedBy(x: viewWidth, y: 0).scaledBy(x: 0.5, y: 0.5)
        toViewController?.view.transform = toViewTransFrom!
        let toViewTransTo = toViewOriginTrans?.translatedBy(x: 0, y: 0).scaledBy(x: 1.0, y: 1.0)
        
        let fromViewOriginTrans = fromViewController?.view.transform
        let fromViewTransTo = fromViewOriginTrans?.translatedBy(x: -viewWidth, y: 0).scaledBy(x: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.3, animations: {
            toViewController?.view.transform = toViewTransTo!
            fromViewController?.view.transform = fromViewTransTo!
            
        }, completion: {finishded in
            self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
            fromViewController!.view.transform = CGAffineTransform.identity
            
        })
    }
}
