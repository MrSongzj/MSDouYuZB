//
//  ScrollCycleCell.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/4.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class ScrollCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var screenIMGV: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    
    var item: ScrollCycleItem? {
        didSet {
            titleLB.text = item?.title
            screenIMGV.kf.setImage(with: URL(string: item?.pic_url ?? ""), placeholder: UIImage(named: "Img_default"))
        }
    }
}
