//
//  CZEmticonInputView.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/20.
//

import UIKit

fileprivate let cellId = "cellId"

class CZEmticonInputView: UIView {
    
    @IBOutlet weak var CZEmticonToolbar: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    class func inputView() -> CZEmticonInputView {
        let nib = UINib(nibName: "CZEmticonInputView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CZEmticonInputView
        return v
    }
    
    override func awakeFromNib() {
        let nib = UINib(nibName: "CZEmticonCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
}

extension CZEmticonInputView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CZEmoticonManager.shared.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CZEmticonCell
        
        cell.label.text = "\(indexPath.section) - \(indexPath.item)"
    
        return cell
    }
    
}
