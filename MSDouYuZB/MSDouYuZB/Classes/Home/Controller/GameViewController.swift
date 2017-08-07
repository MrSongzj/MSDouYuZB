//
//  GameViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/7.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 2*kItemMargin)/3
private let kNormalItemH: CGFloat = kItemW * 6/5
private let kHeaderH: CGFloat = 50

class GameViewController: UIViewController,
UICollectionViewDataSource
{
    
    // MARK: - 属性
    
    private lazy var collectionV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.backgroundColor = UIColor.white
        collectionV.dataSource = self
        collectionV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionV.register(UINib(nibName: "RecommendCateCell", bundle: nil), forCellWithReuseIdentifier: "RecommendCateCell")
        
        return collectionV
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCateCell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    // MARK: - UI
    
    func setupUI() {
        view.addSubview(collectionV)
    }
    
}
