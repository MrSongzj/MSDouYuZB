//
//  GameViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/7.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kGameItemW: CGFloat = (kScreenW - 2*kItemMargin)/3
private let kGmaeItemH: CGFloat = kGameItemW * 6/5
private let kHeaderH: CGFloat = 50

private let kCateVH: CGFloat = 90

class GameViewController: UIViewController,
UICollectionViewDataSource
{
    
    // MARK: - 属性
    
    private lazy var presenter = GamePresenter()
    
    private lazy var collectionV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kGameItemW, height: kGmaeItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.backgroundColor = UIColor.white
        collectionV.dataSource = self
        collectionV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionV.register(UINib(nibName: "RecommendCateCell", bundle: nil), forCellWithReuseIdentifier: "RecommendCateCell")
        collectionV.register(UINib(nibName: "HomeSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeSectionHeaderView")
        
        return collectionV
    }()
    
    private lazy var topHeaderV: HomeSectionHeaderView = {
        let topHeaderV = HomeSectionHeaderView.getView()
        topHeaderV.frame = CGRect(x: 0, y: -kHeaderH-kCateVH, width: kScreenW, height: kHeaderH)
        topHeaderV.titleLB.text = "常见"
        topHeaderV.iconIMGV.image = UIImage(named: "Img_orange")
        topHeaderV.moreBTN.isHidden = true
        
        return topHeaderV
    }()
    
    
    private lazy var cateV: RecommendCateView = {
        let cateV = RecommendCateView.getView()
        cateV.frame = CGRect(x: 0, y: -kCateVH, width: kScreenW, height: kCateVH)
        return cateV
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    // MARK: - Private Methods
    
    func loadData() {
        self.presenter.requestGameCate {
            // 展示所有游戏分类
            self.collectionV.reloadData()
            // 展示常用游戏分类
            self.cateV.cateArr = Array(self.presenter.gameCateArr[0..<10])
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.gameCateArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCateCell", for: indexPath) as! RecommendCateCell
        let gameCate = presenter.gameCateArr[indexPath.row]
        cell.cate = gameCate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeSectionHeaderView", for: indexPath) as! HomeSectionHeaderView
        view.titleLB.text = "全部"
        view.iconIMGV.image = UIImage(named: "Img_orange")
        view.moreBTN.isHidden = true
        
        return view
    }
    
    // MARK: - UI
    
    func setupUI() {
        view.addSubview(collectionV)
        
        collectionV.addSubview(topHeaderV)
        collectionV.addSubview(cateV)
        collectionV.contentInset = UIEdgeInsets(top: kHeaderH + kCateVH, left: 0, bottom: 0, right: 0)
    }
    
}
