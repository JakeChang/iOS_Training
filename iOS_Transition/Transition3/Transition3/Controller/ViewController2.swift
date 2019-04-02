//
//  ViewController2.swift
//  Transition3
//
//  Created by jake on 2019/1/19.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    let customTransitionDelegate = TransitioningDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = customTransitionDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        //panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        //let translate = gesture.translation(in: gesture.view)
        //let percent = (translate.y ) / gesture.view!.frame.height
        //print(translate.y, gesture.view!.bounds.size.height, gesture.view!.frame.height, percent)

        let progress = gesture.translation(in: self.view).y / self.view.bounds.height

        if gesture.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            customTransitionDelegate.interactiveTransition = interactionController
            
            dismiss(animated: true)
        }
        else if gesture.state == .changed {
            interactionController?.update(progress)
        }
        else if gesture.state == .ended {
            //let velocity = gesture.velocity(in: gesture.view)
            
            interactionController?.completionSpeed = 0.999  // https://stackoverflow.com/a/42972283/1271826
            
            if (progress > 0.5) {
                interactionController?.finish()
            }
            else {
                interactionController?.cancel()
            }
            
            customTransitionDelegate.interactiveTransition = nil
            interactionController = nil
        }
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
