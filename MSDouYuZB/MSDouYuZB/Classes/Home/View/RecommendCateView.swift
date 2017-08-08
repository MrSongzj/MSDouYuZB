//
//  RecommendCateView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/7.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class RecommendCateView: UIView,
UICollectionViewDataSource
{
    
    // MARK: - 属性
    
    @IBOutlet weak var collectionV: UICollectionView!
    
    var cateArr: [TVCateProtocol]? {
        didSet {
            collectionV.reloadData()
        }
    }

    // MARK: - 构造器
    
    static func getView() -> RecommendCateView {
        return Bundle.main.loadNibNamed("RecommendCateView", owner: nil, options: nil)?.first as! RecommendCateView
    }
    
    override func awakeFromNib() {
        collectionV.register(UINib(nibName: "RecommendCateCell", bundle: nil), forCellWithReuseIdentifier: "RecommendCateCell")
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cateArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCateCell", for: indexPath) as! RecommendCateCell
        cell.cate = cateArr![indexPath.row]
        
        return cell
    }
    
}
