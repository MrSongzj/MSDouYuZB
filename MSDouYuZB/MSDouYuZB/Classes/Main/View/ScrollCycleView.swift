//
//  ScrollCycleView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/4.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kScrollCellID = "kScrollCellID"

class ScrollCycleView: UIView,
    UICollectionViewDataSource,
    UICollectionViewDelegate
{
    
    var itemArr: [ScrollCycleItem]? {
        didSet {
            guard let itemArr = itemArr else { return }
            
            collectionV.reloadData()
            pageControl.numberOfPages = itemArr.count
        }
    }
    
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    static func getView() -> ScrollCycleView {
        return Bundle.main.loadNibNamed("ScrollCycleView", owner: nil, options: nil)?.first as! ScrollCycleView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionV.register(UINib(nibName: "ScrollCycleCell", bundle: nil), forCellWithReuseIdentifier: kScrollCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kScrollCellID, for: indexPath) as! ScrollCycleCell
        cell.item = itemArr![indexPath.row]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        pageControl.currentPage = page
    }
    
}
