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
    
    // MARK: - 属性

    var cycleTimer: Timer?
    
    var itemArr: [ScrollCycleItem]? {
        didSet {
            guard let itemArr = itemArr else { return }
            
            collectionV.reloadData()
            pageControl.numberOfPages = itemArr.count
            
            // 默认从中间某段开始滚动
            let indexPath = IndexPath(row: itemArr.count*100, section: 0)
            collectionV.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 添加定时器
            removeTimer()
            addTimer()
        }
    }
    
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - 构造器
    
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
    
    // MARK: - Private Methods
    
    func addTimer() {
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(nexpPage), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    // MARK: - Actions
    
    @objc func nexpPage() {
        let currentIndex = collectionV.indexPathForItem(at: collectionV.contentOffset)
        if var currentIndex = currentIndex {
            currentIndex.row = currentIndex.row + 1
            collectionV.scrollToItem(at: currentIndex, at: .left, animated: true)
        }
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (itemArr?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kScrollCellID, for: indexPath) as! ScrollCycleCell
        cell.item = itemArr![indexPath.row % itemArr!.count]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5) % (itemArr?.count ?? 1)
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
