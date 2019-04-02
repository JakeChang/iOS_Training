//
//  ViewController.swift
//  MemoryLeak2
//
//  Created by jake on 2019/3/11.
//  Copyright © 2019 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        DispatchQueue.global().async { [weak self] in
            guard let sSelf = self else {
                return
            }
            
            sSelf.test()
            
            DispatchQueue.main.async {
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func test() {
        print("test")
    }
}
