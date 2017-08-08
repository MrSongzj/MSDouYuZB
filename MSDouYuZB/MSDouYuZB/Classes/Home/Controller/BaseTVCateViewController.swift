//
//  BaseTVCateViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/8.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
let kItemW: CGFloat = (kScreenW - 3*kItemMargin)/2
let kNormalItemH: CGFloat = kItemW * 3/4
private let kHeaderH: CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderID = "kHeaderID"

protocol BaseTVCateVCDataSource {
    var tvCateArr: [TVCate] { get }
}

class BaseTVCateViewController: UIViewController,
    UICollectionViewDataSource
{
    
    // MARK: - 属性
    
    var dataSource: BaseTVCateVCDataSource!
    
    lazy var collectionV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.backgroundColor = UIColor.white
        collectionV.dataSource = self
        collectionV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionV.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionV.register(UINib(nibName: "HomeSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collectionV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    // MARK: - Public Methods
    
    func loadData() {
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.tvCateArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.tvCateArr[section].roomArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionV.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.tvRoom = dataSource.tvCateArr[indexPath.section].roomArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HomeSectionHeaderView
        view.cate = dataSource.tvCateArr[indexPath.section]
        
        return view
    }
    
    // MARK: - UI
    
    func setupUI() {
        view.addSubview(collectionV)
    }

}
