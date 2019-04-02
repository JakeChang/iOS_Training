//
//  ViewController.swift
//  Transition2
//
//  Created by jake on 2019/1/19.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        present(controller, animated: true, completion: nil)
    }
    
}
