//
//  RecommendViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/2.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH: CGFloat = kItemW * 3/4
private let kPrettyItemH: CGFloat = kItemW * 4/3
private let kHeaderH: CGFloat = 50

private let kScrollCycleVH: CGFloat = kScreenW * 3/8

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderID = "kHeaderID"

class RecommendViewController: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    // MARK: - 属性
    
    private lazy var presenter = RecommendPresenter()
    
    private lazy var scrollCycleV: ScrollCycleView = {
        let scrollCycleV = ScrollCycleView.getView()
        scrollCycleV.frame = CGRect(x: 0, y: -kScrollCycleVH, width: kScreenW, height: kScrollCycleVH)
        return scrollCycleV
    }()
    
    private lazy var collectionV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.backgroundColor = UIColor.white
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionV.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionV.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionV.register(UINib(nibName: "HomeSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collectionV
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func loadData() {
        // 请求直播数据
        presenter.requestTVData { [weak self] in
            self?.collectionV.reloadData()
        }
        // 请求循环轮播数据
        presenter.requestScrollCycleData {[weak self] in
            self?.scrollCycleV.itemArr = self?.presenter.scrollCycleItemArr
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.tvCateArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cate = presenter.tvCateArr[section]
        return cate.roomArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cate = presenter.tvCateArr[indexPath.section]
        let room = cate.roomArr[indexPath.row]
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.tvRoom = room
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.tvRoom = room
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HomeSectionHeaderView
        view.cate = presenter.tvCateArr[indexPath.section]
        return view
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.addSubview(collectionV)
        collectionV.addSubview(scrollCycleV)
        collectionV.contentInset = UIEdgeInsets(top: kScrollCycleVH, left: 0, bottom: 0, right: 0)
    }
}
