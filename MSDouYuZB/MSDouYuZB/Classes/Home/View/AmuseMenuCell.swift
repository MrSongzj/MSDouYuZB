//
//  AmuseMenuCell.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/8.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class AmuseMenuCell: UICollectionViewCell,
    UICollectionViewDataSource
{
    // MARK: - 属性
    
    @IBOutlet weak var collectionV: UICollectionView!
    
    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionV.register(UINib(nibName: "RecommendCateCell", bundle: nil), forCellWithReuseIdentifier: "RecommendCateCell")
        
        let layout = collectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kScreenW/4, height: 85)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCateCell", for: indexPath) as! RecommendCateCell
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }

}
