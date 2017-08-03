//
//  PageContentView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/31.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

protocol PageContentViewDelegate: class {
    func pageContentVeiw(_ view: PageContentView,didScroll progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

class PageContentView: UIView,
UICollectionViewDataSource,
UICollectionViewDelegate
{
    // MARK: - 属性
    
    private let childVCs: [UIViewController]
    private unowned let parentVC: UIViewController
    private var sourceIndex = 0
    private var lastOffsetX: CGFloat = 0
    private var isPassDelegate = false
    weak var delegate: PageContentViewDelegate?
    
    private lazy var collectionV: UICollectionView = {
        // 创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.showsHorizontalScrollIndicator = false
        v.isPagingEnabled = true
        v.frame = self.bounds
        v.bounces = false
        v.dataSource = self
        v.delegate = self
        v.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)

        return v
    }()

    // MARK: - 构造器
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Publick Methods
    func setCurrentIndex(_ index: Int) {
        isPassDelegate = true
        let offset = CGFloat(index) * collectionV.frame.size.width
        collectionV.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let vc = childVCs[indexPath.row]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isPassDelegate = false
        sourceIndex = Int(scrollView.contentOffset.x / collectionV.frame.width)
        lastOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isPassDelegate { return }
        
        let currentOffsetX = scrollView.contentOffset.x
        let w = collectionV.frame.width
        let sourceOffsetX = CGFloat(sourceIndex)*w
        let dif = currentOffsetX - sourceOffsetX
        let progress = min(abs(dif / w), 1)
        
        var targetIndex = 0
        // 当差值等于 0 时，需要判断方向才可以确定 targetIndex
        if dif == 0 {
            // 通过上一次的 x 偏移量来确定方向
            let lastDif = lastOffsetX - sourceOffsetX
            targetIndex = lastDif > 0 ? sourceIndex+1 : sourceIndex-1
        } else {
            targetIndex = dif > 0 ? sourceIndex+1 : sourceIndex-1
        }
        delegate?.pageContentVeiw(self, didScroll: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
//        print(progress, sourceIndex, targetIndex)
        // 进度等于 1 的时候更新 sourceIndex
        if progress == 1 {
            sourceIndex = targetIndex
        }
        lastOffsetX = currentOffsetX
    }
    
    // MARK: - UI
    
    private func setupUI() {
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
        addSubview(collectionV)
    }
}
