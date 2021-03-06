//
//  HomeViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/28.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kPageTitleVH: CGFloat = 40

class HomeViewController: UIViewController,
PageTitleViewDelegate,
PageContentViewDelegate
{
    // MARK: - 属性
    private lazy var pageTitleV: PageTitleView = {
        let v = PageTitleView(frame: CGRect(x: 0, y: kNavigationBarBottom, width: kScreenW, height: kPageTitleVH), titles: ["推荐", "游戏", "娱乐", "趣玩"])
        v.delegate = self
        return v
    }()
    
    private lazy var pageContentV: PageContentView = {
        // 设置 frame
        let frame = CGRect(x: 0, y: kNavigationBarBottom + kPageTitleVH, width: kScreenW, height: kScreenH - kNavigationBarBottom - kPageTitleVH - kTabBarH)
        // 添加自控制器
        var vcs = [UIViewController]()
        vcs.append(RecommendViewController())
        vcs.append(GameViewController())
        vcs.append(AmuseViewController())
        vcs.append(FunnyViewController())
        
        let v = PageContentView(frame: frame, childVCs: vcs, parentVC: self)
        v.delegate = self
        return v
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - PageTitleViewDelegate
    func pageTitleView(_ view: PageTitleView, didSelectedAt index: Int) {
        pageContentV.setCurrentIndex(index)
    }
    
    // MARK: - PageContentViewDelegate
    func pageContentVeiw(_ view: PageContentView, didScroll progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleV.scrollTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    // MARK: - UI
    private func setupUI() {
        // 不自动调整 scrollView 的偏移量
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        view.addSubview(pageTitleV)
        view.addSubview(pageContentV)
    }
    
    private func setupNavigationBar() {
        // 设置左侧 Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImgName: "logo")
        
        // 设置右侧 Items
        navigationItem.rightBarButtonItems =
            [UIBarButtonItem(normalImgName: "image_my_history", highlightImgName: "Image_my_history_click", width: 38),
             UIBarButtonItem(normalImgName: "btn_search", highlightImgName: "btn_search_clicked", width: 38),
             UIBarButtonItem(normalImgName: "Image_scan", highlightImgName: "Image_scan_click", width: 38)]
    }
}
