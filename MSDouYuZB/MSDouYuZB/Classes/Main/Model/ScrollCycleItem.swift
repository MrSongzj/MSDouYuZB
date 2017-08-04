//
//  ScrollCycleItem.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/4.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class ScrollCycleItem: BaseModel {
    // 标题
    var title = ""
    // 图片
    var pic_url = ""
    // 房间信息
    var room: [String: Any]? {
        didSet {
            if let room = room {
                tvRoom = TVRoom(dict: room)
            }
        }
    }
    // 房间对象
    var tvRoom: TVRoom?
}
