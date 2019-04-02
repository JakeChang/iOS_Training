//
//  TabBarController.swift
//  TabTransition2
//
//  Created by jake on 2019/1/21.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        //print(fromVC.tabBarItem.tag, toVC.tabBarItem.tag)
        
        //按右邊
        if fromVC.tabBarItem.tag < toVC.tabBarItem.tag {
            return AnimatedTransitioning(transitionType: .presenting)
        }
        else {
            return AnimatedTransitioning(transitionType: .dismissing)
        }
        
    }

}

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum TransitionType {
        case presenting
        case dismissing
    }
    
    let transitionType: TransitionType
    
    init(transitionType: TransitionType) {
        self.transitionType = transitionType
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let inView   = transitionContext.containerView
        let frame = inView.bounds
        
        switch transitionType {
        case .presenting:
            let fromView = transitionContext.viewController(forKey: .from)
            let toView   = transitionContext.viewController(forKey: .to)
            
            toView?.view.frame = CGRect(x: inView.frame.minX + 50, y: inView.frame.minY, width: inView.frame.width, height: inView.frame.height)
            toView?.view.alpha = 0.0
            
            inView.addSubview(toView!.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView?.view.frame = CGRect(x: inView.frame.minX - 50, y: inView.frame.minY, width: inView.frame.width, height: inView.frame.height)
                fromView?.view.alpha = 0.0

                toView?.view.frame = CGRect(x: inView.frame.minX, y: inView.frame.minY, width: inView.frame.width, height: inView.frame.height)
                toView?.view.alpha = 1.0

            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            })
            
        case .dismissing:
            let fromView = transitionContext.viewController(forKey: .from)
            let toView   = transitionContext.viewController(forKey: .to)
            
            toView?.view.frame = CGRect(x: inView.frame.minX - 50, y: inView.frame.minY, width: inView.frame.width, height: inView.frame.height)
            toView?.view.alpha = 0.0

            inView.insertSubview(toView!.view, belowSubview: fromView!.view)

            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView?.view.frame = CGRect(x: inView.frame.minX + 50, y: inView.frame.minY, width: inView.frame.width, height: inView.frame.height)
                fromView?.view.alpha = 0.0
                
                toView?.view.frame = CGRect(x: inView.frame.minX, y: inView.frame.minY, width: inView.frame.width, height: inView.frame.height)
                toView?.view.alpha = 1.0

            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            })
        }
    }
    
}
