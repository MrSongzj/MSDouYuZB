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

    var cate: TVCate? {
        didSet {
            guard let cate = cate else { return }
            
            icon.kf.setImage(with: URL(string: cate.small_icon_url), placeholder: UIImage(named: cate.icon_name))
            title.text = cate.tag_name
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
}
