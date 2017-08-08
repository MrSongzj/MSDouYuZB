//
//  RecommendCateCell.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/7.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class RecommendCateCell: UICollectionViewCell {
    
    @IBOutlet weak var iconIMGV: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    
    var cate: TVCateProtocol? {
        didSet {
            nameLB.text = cate?.tag_name
            if let url = URL(string: cate?.icon_url ?? "") {
                iconIMGV.kf.setImage(with: url)
            } else {
                iconIMGV.image = UIImage(named: "home_more_btn")
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
