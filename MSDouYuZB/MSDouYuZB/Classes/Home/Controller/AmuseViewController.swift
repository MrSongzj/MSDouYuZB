//
//  AmuseViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/8.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kMenuVH: CGFloat = 200

class AmuseViewController: BaseTVCateViewController
{
    
    // MARK: - 属性
    private lazy var presenter = AmusePresenter()
    
    private lazy var menuV: AmuseMenuView = {
        let menuV = AmuseMenuView.getView()
        menuV.frame = CGRect(x: 0, y: -kMenuVH, width: kScreenW, height: kMenuVH)
        
        return menuV
    }()
    
    // MARK: - Private Methods
    
    override func loadData() {
        
        dataSource = presenter
        
        showLoading()
        presenter.requestAmuseData {
            self.hideLoading()
            
            self.collectionV.reloadData()
            // 设置菜单数据
            var cateArr = self.presenter.tvCateArr
            cateArr.removeFirst()
            self.menuV.cateArr = cateArr
        }
    }
    
    // MARK: - UI
    
    override func setupUI() {
        super.setupUI()
        
        collectionV.addSubview(menuV)
        collectionV.contentInset = UIEdgeInsets(top: kMenuVH, left: 0, bottom: 0, right: 0)
    }

}
