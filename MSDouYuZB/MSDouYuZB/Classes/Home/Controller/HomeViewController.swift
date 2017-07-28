//
//  HomeViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/28.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        // 设置左侧 Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImgName: "logo")
        
        // 设置右侧 Items
        navigationItem.rightBarButtonItems =
            [UIBarButtonItem(normalImgName: "image_my_history", highlightImgName: "Image_my_history_click"),
             UIBarButtonItem(width: 25),
             UIBarButtonItem(normalImgName: "btn_search", highlightImgName: "btn_search_clicked"),
             UIBarButtonItem(width: 25),
             UIBarButtonItem(normalImgName: "Image_scan", highlightImgName: "Image_scan_click")]
    }
}
