//
//  ViewController.swift
//  CollectionView3
//
//  Created by jake on 2019/1/23.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //View
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        //新增一個長按的手勢
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGest(gesture:)))
        collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func handleLongPressGest(gesture: UILongPressGestureRecognizer) {
        print(gesture.state.rawValue)
        
        switch gesture.state {
        case .began:
            //取得選取的cell
            let point = gesture.location(in: collectionView)
            let selectedIndexPath = collectionView.indexPathForItem(at: point)
            
            //
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath!)
            
            break
            
        case .changed:
            let point = gesture.location(in: collectionView)
            collectionView.updateInteractiveMovementTargetPosition(point)
            
            break
            
        case .ended:
            collectionView.endInteractiveMovement()
            
            break
            
        default:
            collectionView.cancelInteractiveMovement()
            
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    //是否可以移動cell
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        print(sourceIndexPath.row, destinationIndexPath.row)
        
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
    }
}
