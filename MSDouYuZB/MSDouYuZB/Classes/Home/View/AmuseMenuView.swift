//
//  AmuseMenuView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/8.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView,
    UICollectionViewDataSource,
    UICollectionViewDelegate
{
    // MARK: - 属性
    
    var cateArr: [TVCateProtocol]? {
        didSet {
            collectionV.reloadData()
            
            pageControl.numberOfPages = pageCount
        }
    }
    
    var pageCount: Int {
        let count = cateArr?.count ?? 0
        if count > 0 {
            return (count + 7) / 8
        }
        return 0
    }
    
    
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
        return pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmuseMenuCell", for: indexPath) as! AmuseMenuCell
        cell.cateArr = cateArrForPage(indexPath.row)
        
        return cell
    }
    
    private func cateArrForPage(_ page: Int) -> [TVCateProtocol] {
        let startIndex = page * 8
        var endIndex = startIndex + 7
        if endIndex > cateArr!.count - 1 {
            endIndex = cateArr!.count - 1
        }
        return Array(cateArr![startIndex...endIndex])
    }

    // MARK: - UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
