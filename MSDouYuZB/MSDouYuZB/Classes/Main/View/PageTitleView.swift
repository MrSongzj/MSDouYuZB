//
//  PageTitleView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/31.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

private let kNormalColor = UIColor.darkGray
private let kHighlightColor = UIColor.orange
private let kNormalColorRGBA = kNormalColor.getRGBA()
private let kHighlightColorRGBA = kHighlightColor.getRGBA()

protocol PageTitleViewDelegate: class {
    func pageTitleView(_ view: PageTitleView, didSelectedAt index: Int)
}

class PageTitleView: UIView {
    
    // MARK: - 属性
    private let titles: [String]
    private var titleLBs = [UILabel]()
    private var currentIndex = 0
    weak var delegate: PageTitleViewDelegate?
    
    private lazy var scrollV: UIScrollView = {
        let v = UIScrollView()
        v.showsHorizontalScrollIndicator = false
        v.scrollsToTop = false
        v.bounces = false
        return v
    }()
    private lazy var scrollLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.orange
        return v
    }()

    // MARK: - 构造器
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Publick Methods
    // 滑动 titleView
    func scrollTitle(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        let sourceLB = titleLBs[sourceIndex]
        let targetLB = titleLBs[targetIndex]
        
        // 改变字体颜色
        sourceLB.textColor = UIColor.transferRGBA(kHighlightColorRGBA, toRGBA: kNormalColorRGBA, progress: progress)
        targetLB.textColor = UIColor.transferRGBA(kNormalColorRGBA, toRGBA: kHighlightColorRGBA, progress: progress)
        // 滚动 scrollLine
        let startX = sourceLB.frame.origin.x
        let endX = targetLB.frame.origin.x
        scrollLine.frame.origin.x = startX + (endX - startX)*progress
        // 更新当前索引
        if progress == 1 {
            currentIndex = targetIndex
        }
    }
    
    // MARK: - Actions
     @objc private func tapLB(sender: UITapGestureRecognizer) {
        guard let tapLB = sender.view as? UILabel else { return }
        guard tapLB.tag != currentIndex  else { return }
        
        // 改变颜色
        tapLB.textColor = kHighlightColor
//        let lastLB = titleLBs[currentIndex]
//        lastLB.textColor = kNormalColor
        for lb in titleLBs {
            if lb !== tapLB {
                lb.textColor = kNormalColor
            }
        }
        
        currentIndex = tapLB.tag

        // 改变底部 line 的位置
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = tapLB.frame.origin.x
        }
        
        delegate?.pageTitleView(self, didSelectedAt: currentIndex)
    }
    
    // MARK: - UI
    private func setupUI() {
        scrollV.frame = bounds
        addSubview(scrollV)
        // 配置 titles
        setupTitles()
        // 添加 scrollLine
        scrollV.addSubview(scrollLine)
        // 添加底部分割线
        let bottomLineH: CGFloat = kOnePX
        let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height - bottomLineH, width: frame.width, height: bottomLineH))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        // 配置初始选中状态
        guard let lb = titleLBs.first else { return }
        
        lb.textColor = UIColor.orange
        let scrollLineH: CGFloat = 2
        scrollLine.frame = CGRect(x: lb.frame.origin.x, y: frame.size.height - scrollLineH, width: lb.frame.size.width, height: scrollLineH)
    }
    
    /// 配置标题视图
    private func setupTitles() {
        let w = frame.size.width / CGFloat(self.titles.count)
        for (index, title) in titles.enumerated() {
            let lb = UILabel(frame: CGRect(x: w * CGFloat(index), y: 0, width: w, height: frame.size.height))
            lb.text = title
            lb.textColor = UIColor.darkGray
            lb.textAlignment = .center
            lb.font = UIFont.systemFont(ofSize: 16)
            lb.tag = index
            
            scrollV.addSubview(lb)
            titleLBs.append(lb)
            
            // 添加点击手势
            lb.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapLB(sender:)))
            lb.addGestureRecognizer(tapGes)
        }
    }
}
