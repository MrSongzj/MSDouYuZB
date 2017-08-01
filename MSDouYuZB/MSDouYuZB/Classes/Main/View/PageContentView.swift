//
//  PageContentView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/31.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView, UICollectionViewDataSource {
    // MARK: - 属性
    private let childVCs: [UIViewController]
    private unowned let parentVC: UIViewController
    
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
        v.dataSource = self
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
    
    // MARK: - UI
    private func setupUI() {
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
        addSubview(collectionV)
    }
}
