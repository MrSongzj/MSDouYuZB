//
//  FunnyViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/9.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class FunnyViewController: BaseTVCateViewController {

    // MARK: - 属性
    
    lazy var presenter = FunnyPresenter()
    
    // MARK: - Private Methods
    
    override func loadData() {
        dataSource = presenter
        
        showLoading()
        presenter.requestFunnyData {
            self.hideLoading()
            
            self.collectionV.reloadData()
        }
    }
    
    // MARK: - UI
    
    override func setupUI() {
        super.setupUI()
        
        // 去掉 headerV
        let layout = collectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        // 调整分区边距
        layout.sectionInset.top = 8
        layout.sectionInset.bottom = 8
    }
    
}
