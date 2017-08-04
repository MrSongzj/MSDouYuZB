//
//  TVCate.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class TVCate: BaseModel {
    /// 房间模型数组
    var roomArr = [TVRoom]()
    /// 该组中对应的房间信息
    var room_list: [[String: Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            
            for dict in room_list {
                roomArr.append(TVRoom(dict: dict))
            }
        }
    }
    /// 组标题
    var tag_name = ""
    /// 组默认图标
    var icon_name = "home_header_normal"
    /// 组图标
    var small_icon_url = ""
}
