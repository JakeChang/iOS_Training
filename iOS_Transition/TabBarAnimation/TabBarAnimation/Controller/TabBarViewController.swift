//
//  TabBarViewController.swift
//  TabBarAnimation
//
//  Created by jake on 2019/1/14.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //
    var itemImageView1: UIImageView?
    var itemImageView2: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        let tabView1 = self.tabBar.subviews[0]
        let tabView2 = self.tabBar.subviews[1]

        itemImageView1 = tabView1.subviews.first as? UIImageView
        itemImageView2 = tabView2.subviews.first as? UIImageView

    }
    
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            self.itemImageView1?.transform = CGAffineTransform.identity

            UIView.animate(withDuration: 0.1, animations: {
                self.itemImageView1?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { finished in
                UIView.animate(withDuration: 0.1, animations: {
                    self.itemImageView1?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }, completion: { finished in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.itemImageView1?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: { finished in
                        
                    })
                })
            })
            
        }
        else {
            self.itemImageView2?.transform = CGAffineTransform.identity

            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.itemImageView2?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }, completion: { finished in
                
            })
        }
    }
    
}
