//
//  ViewController.swift
//  CollectionView4
//
//  Created by jake on 2019/1/23.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //View
    @IBOutlet weak var collectionView: UICollectionView!
    
    //
    var collectionArray: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dragInteractionEnabled = true
        
        //
        for i in 1...10 {
            collectionArray.append(i)
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = String(collectionArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let s = NSString(string: "test")
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: s))
        
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let sourceIndexPath = coordinator.items.first?.sourceIndexPath
        let destinationIndexPath = coordinator.destinationIndexPath
        
        print(sourceIndexPath?.row, destinationIndexPath?.row)
        
        collectionView.performBatchUpdates({
            let item = self.collectionArray[(sourceIndexPath?.row)!]
            
            self.collectionArray.remove(at: (sourceIndexPath?.row)!)
            self.collectionArray.insert(item, at: (destinationIndexPath?.row)!)
            collectionView.moveItem(at: sourceIndexPath!, to: destinationIndexPath!)
            
        }, completion: nil)
        
        coordinator.drop((coordinator.items.first?.dragItem)!, toItemAt: destinationIndexPath!)
    }
}
