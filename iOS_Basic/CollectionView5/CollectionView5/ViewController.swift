//
//  ViewController.swift
//  CollectionView5
//
//  Created by jake on 2019/3/5.
//  Copyright © 2019 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //View
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: CollectionViewCell.ID, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.ID)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.ID, for: indexPath) as! CollectionViewCell
        
        return cell
    }
}
