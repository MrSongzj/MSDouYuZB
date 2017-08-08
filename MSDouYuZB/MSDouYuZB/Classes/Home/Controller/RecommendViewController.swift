//
//  RecommendViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/2.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kPrettyItemH: CGFloat = kItemW * 4/3

private let kScrollCycleVH: CGFloat = kScreenW * 3/8
private let kCateVH: CGFloat = 90

private let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: BaseTVCateViewController,
    UICollectionViewDelegateFlowLayout
{
    // MARK: - 属性
    
    private lazy var presenter = RecommendPresenter()
    
    private lazy var scrollCycleV: ScrollCycleView = {
        let scrollCycleV = ScrollCycleView.getView()
        scrollCycleV.frame = CGRect(x: 0, y: -kScrollCycleVH-kCateVH, width: kScreenW, height: kScrollCycleVH)
        return scrollCycleV
    }()
    
    private lazy var cateV: RecommendCateView = {
        let cateV = RecommendCateView.getView()
        cateV.frame = CGRect(x: 0, y: -kCateVH, width: kScreenW, height: kCateVH)
        return cateV
    }()
    
    // MARK: - Private Methods
    
    override func loadData() {
        dataSource = presenter
        
        // 请求直播数据
        presenter.requestTVData { [weak self] in
            // 展示各个分类的直播数据
            self?.collectionV.reloadData()
            // 展示推荐的分类数据
            // 移除热门和颜值分类
            var cateArr = self?.presenter.tvCateArr
            cateArr?.removeFirst()
            cateArr?.removeFirst()
            // 追加更多分类
            let cate = TVCate()
            cate.tag_name = "更多"
            
            cateArr?.append(cate)
            self?.cateV.cateArr = cateArr
        }
        // 请求循环轮播数据
        presenter.requestScrollCycleData {[weak self] in
            self?.scrollCycleV.itemArr = self?.presenter.scrollCycleItemArr
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.tvRoom = presenter.tvCateArr[indexPath.section].roomArr[indexPath.row]
            return cell
        }

        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    // MARK: - UI
    
    override func setupUI() {
        super.setupUI()
        
        collectionV.delegate = self
        collectionV.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionV.addSubview(scrollCycleV)
        collectionV.addSubview(cateV)
        collectionV.contentInset = UIEdgeInsets(top: kScrollCycleVH + kCateVH, left: 0, bottom: 0, right: 0)
    }
}
