//
//  HomeSectionHeaderView.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit
import Kingfisher

class HomeSectionHeaderView: UICollectionReusableView {

    // MARK: - 属性
    
    var cate: TVCate? {
        didSet {
            guard let cate = cate else { return }
            
            iconIMGV.kf.setImage(with: URL(string: cate.small_icon_url), placeholder: UIImage(named: cate.icon_name))
            titleLB.text = cate.tag_name
        }
    }
    
    @IBOutlet weak var moreBTN: UIButton!
    @IBOutlet weak var iconIMGV: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    
    // MARK: - 构造器
    
    static func getView() -> HomeSectionHeaderView {
        return Bundle.main.loadNibNamed("HomeSectionHeaderView", owner: nil, options: nil)?.first as! HomeSectionHeaderView
    }
}
