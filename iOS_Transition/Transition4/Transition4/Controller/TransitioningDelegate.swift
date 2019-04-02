//
//  TransitioningDelegate.swift
//  Transition4
//
//  Created by jake on 2019/1/19.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return AnimatedTransitioning(transitionType: .presenting)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(transitionType: .dismissing)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return PresentationController(presentedViewController: presented, presenting: presenting)
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
            let fromView = transitionContext.viewController(forKey: .from) as! ViewController1
            let toView   = transitionContext.viewController(forKey: .to) as! ViewController2
            
            toView.view.frame = fromView.selectCellRect!
            toView.view.alpha = 0.0

            inView.addSubview(toView.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                toView.view.frame = frame
                toView.view.alpha = 1.0

            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            })
            
        case .dismissing:
            let fromView = transitionContext.viewController(forKey: .from) as! ViewController2
            let toView   = transitionContext.viewController(forKey: .to) as! ViewController1
            
            inView.insertSubview(toView.view, belowSubview: fromView.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.view.frame = fromView.selectCellRect!
                fromView.view.alpha = 0.0
                toView.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            })
        }
        
    }
    
}

class PresentationController: UIPresentationController {
    
    override var shouldRemovePresentersView: Bool {
        return true
    }
    
}
