//
//  CollectionNormalCell.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    var tvRoom: TVRoom? {
        didSet {
            guard let room = tvRoom else { return }
            
            nicknameLB.text = room.nickname
            titleLB.text = room.room_name
            if room.online > 10000 {
                onlineBTN.setTitle(String(format: "%.2f万在线", Double(room.online)/10000), for: .normal)
            } else {
                onlineBTN.setTitle("\(room.online)在线", for: .normal)
            }
            screenIMGV.kf.setImage(with: URL(string: room.vertical_src), placeholder: UIImage(named: "Img_default"))

        }
    }
    
    @IBOutlet weak var screenIMGV: UIImageView!
    @IBOutlet weak var nicknameLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var onlineBTN: UIButton!
}
