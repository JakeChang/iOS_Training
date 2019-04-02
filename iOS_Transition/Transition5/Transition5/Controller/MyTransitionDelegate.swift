//
//  MyTransitionDelegate.swift
//  Transition5
//
//  Created by jake on 2019/1/21.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class MyTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
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
    
            let selectCellRect = (fromView.selectCellRect)!
                        
            let scaleX =  (fromView.selectCellRect?.width)! / fromView.view.frame.width
            let scaleY = (fromView.selectCellRect?.height)! / fromView.view.frame.height
            toView.view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            toView.view.frame = CGRect(x: selectCellRect.minX, y: selectCellRect.minY, width: toView.view.frame.width, height: toView.view.frame.height)
            
            inView.addSubview(toView.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                
                toView.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                toView.view.frame = frame
                
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            })
            
        case .dismissing:
            let fromView = transitionContext.viewController(forKey: .from) as! ViewController2
            let toView   = transitionContext.viewController(forKey: .to) as! ViewController1
            
            let selectCellRect = (fromView.selectCellRect)!

            let scaleX =  (fromView.selectCellRect?.width)! / fromView.view.frame.width
            let scaleY = (fromView.selectCellRect?.height)! / fromView.view.frame.height
            
            inView.insertSubview(toView.view, belowSubview: fromView.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                fromView.view.frame = CGRect(x: selectCellRect.minX, y: selectCellRect.minY, width: fromView.view.frame.width, height: fromView.view.frame.height)
                
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
