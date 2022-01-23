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
    
    // 保存回调闭包
    private var emticonSelectedCallBack: ((_ emticon: CZEmoticon?)->())?
    
//    class func inputView() -> CZEmticonInputView {
//        let nib = UINib(nibName: "CZEmticonInputView", bundle: nil)
//        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CZEmticonInputView
//        return v
//    }
    
    class func inputView(selectedEmticon: @escaping (_ emticon: CZEmoticon?)->()) -> CZEmticonInputView {
        let nib = UINib(nibName: "CZEmticonInputView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CZEmticonInputView
        v.emticonSelectedCallBack = selectedEmticon
        return v
    }
    
    override func awakeFromNib() {
//        let nib = UINib(nibName: "CZEmticonCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(CZEmticonCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension CZEmticonInputView : UICollectionViewDataSource {
    // 分组数量 - 返回表情包的数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CZEmoticonManager.shared.packages.count
    }
    // 返回每个分组中的表情`页`的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CZEmoticonManager.shared.packages[section].numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CZEmticonCell
        
        //cell.label.text = "\(indexPath.section) - \(indexPath.item)"
        
        cell.emoticons = CZEmoticonManager.shared.packages[indexPath.section].emoticon(page: indexPath.item)
        
        cell.delegate = self
    
        return cell
    }
}

extension CZEmticonInputView : CZEmticonCellDelegate {
    
    func emticonCellDidSelectedEmoticon(cell: CZEmticonCell, em: CZEmoticon?) {
        self.emticonSelectedCallBack?(em)
    }
}
