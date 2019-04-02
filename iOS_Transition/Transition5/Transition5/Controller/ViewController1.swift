//
//  ViewController.swift
//  Transition5
//
//  Created by jake on 2019/1/21.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    //View
    @IBOutlet weak var collectionView: UICollectionView!
    
    //
    var selectCellRect: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //View
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }

}

extension ViewController1: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/7, height: collectionView.frame.size.height/5)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let attribute = collectionView.layoutAttributesForItem(at: indexPath)
        let selectRect = collectionView.convert((attribute?.frame)!, to: view)
        
        print(selectRect)
        
        selectCellRect = selectRect
        
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        controller.selectCellRect = selectCellRect
        present(controller, animated: true, completion: nil)
    }
}
