//
//  ViewController.swift
//  Timer
//
//  Created by jake on 2019/3/7.
//  Copyright © 2019 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //
    var timer: DispatchSourceTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    }


    @IBAction func clickButton(_ sender: Any) {

        //宣告每一秒執行一次，誤差允許為10微秒
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(10))
        
        //每一秒要做的事情
        timer?.setEventHandler(handler: {
            
            for i in 1...1000000 {
                print(i)
            }
            
            //將資料提供給前景
            DispatchQueue.main.sync {
                
            }
        })
        
        //開始執行
        timer?.resume()
        
        
        //取消的方式，如果有suspend，則必須要resume再cancel
        timer?.suspend()
        timer?.resume()
        timer?.cancel()
        timer = nil
    }
    
}

