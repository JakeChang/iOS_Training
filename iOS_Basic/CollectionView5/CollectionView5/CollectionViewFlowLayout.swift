//
//  CollectionViewFlowLayout.swift
//  CollectionView5
//
//  Created by jake on 2019/3/5.
//  Copyright © 2019 Jake. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public var scalingOffset: CGFloat = 220 //for offsets >= scalingOffset scale factor is minimumScaleFactor
    public var minimumScaleFactor: CGFloat = 0.7
    
    override func prepare() {
        super.prepare()
        
        print("prepare")
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        print("invalidateLayout")
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: 200, height: 200)
        minimumLineSpacing = 10
        
        let inset = (collectionView?.bounds.size.width)!/2 - itemSize.width/2
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionView?.contentOffset = CGPoint(x: -inset, y: 0)
        collectionView?.decelerationRate = .fast
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if collectionView == nil {
            return proposedContentOffset
        }
        
        let collectionViewSize = collectionView!.bounds.size
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionViewSize.width, height: collectionViewSize.height)
        
        let layoutAttributes = layoutAttributesForElements(in: proposedRect)
        
        if layoutAttributes == nil {
            return proposedContentOffset
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width / 2
        
        for attributes: UICollectionViewLayoutAttributes in layoutAttributes! {
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            if abs(attributes.center.x - proposedContentOffsetCenterX) < abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        
        if candidateAttributes == nil {
            return proposedContentOffset
        }
        
        var newOffsetX = candidateAttributes!.center.x - collectionView!.bounds.size.width / 2
        
        let offset = newOffsetX - collectionView!.contentOffset.x
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = self.itemSize.width + self.minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        
        //print(CGPoint(x: newOffsetX, y: proposedContentOffset.y))
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
    
    /*
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    */
    
    /*
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if collectionView == nil {
            return super.layoutAttributesForElements(in: rect)
        }
        
        let superAttributes = super.layoutAttributesForElements(in: rect)
        if superAttributes == nil {
            return nil
        }
        
        let contentOffset = collectionView!.contentOffset
        let size = collectionView!.bounds.size
        
        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX
        
        var newAttributesArray = Array<UICollectionViewLayoutAttributes>()
        
        for (_, attributes) in superAttributes!.enumerated() {
            let newAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
            newAttributesArray.append(newAttributes)
            let distanceFromCenter = visibleCenterX - newAttributes.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), self.scalingOffset)
            let scale = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1
            newAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        
        return newAttributesArray
    }
    */
}
