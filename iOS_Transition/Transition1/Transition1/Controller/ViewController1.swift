//
//  ViewController.swift
//  Transition1
//
//  Created by jake on 2019/1/14.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        self.present(controller, animated: true, completion: nil)
    }
    
}
