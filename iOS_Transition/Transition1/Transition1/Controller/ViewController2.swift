//
//  SecondViewController.swift
//  Transition1
//
//  Created by jake on 2019/1/14.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    //
    let customTransitionDelegate = TransitioningDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //
        modalPresentationStyle = .custom
        transitioningDelegate = customTransitionDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
