//
//  CollectionPrettyCell.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
    
    var tvRoom: TVRoom? {
        didSet {
            guard let room = tvRoom else { return }
            
            nicknameLB.text = room.nickname
            locationBTN.setTitle(room.anchor_city, for: .normal)
            if room.online > 10000 {
                onlineLB.text = String(format: "%.2f万在线", Double(room.online)/10000)
            } else {
                onlineLB.text = "\(room.online)在线"
            }
            screenIMGV.kf.setImage(with: URL(string: room.vertical_src), placeholder: UIImage(named: "live_cell_default_phone"))
        }
    }
    
    @IBOutlet weak var screenIMGV: UIImageView!
    @IBOutlet weak var nicknameLB: UILabel!
    @IBOutlet weak var locationBTN: UIButton!
    @IBOutlet weak var onlineLB: UILabel!

}
