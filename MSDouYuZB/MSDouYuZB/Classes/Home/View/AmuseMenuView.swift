//
//  AmuseMenuView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/8.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView,
    UICollectionViewDataSource
{
    // MARK: - 属性
    
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - 构造器
    
    static func getView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionV.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: "AmuseMenuCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionV.bounds.size
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmuseMenuCell", for: indexPath) as! AmuseMenuCell
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }

}
