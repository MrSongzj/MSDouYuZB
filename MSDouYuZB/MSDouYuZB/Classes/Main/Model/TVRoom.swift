//
//  TVRoom.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class TVRoom: BaseModel {
    /// 房间 ID
    var room_id = 0
    /// 房间图片对应的 URLString
    var vertical_src = ""
    /// 判断是手机直播还是电脑直播
    // 0: 电脑直播 1: 手机直播
    var isVertival = 0
    /// 房间名称
    var room_name = ""
    /// 主播昵称
    var nickname = ""
    /// 观看人数
    var online = 0
    /// 所在城市
    var anchor_city = ""
}
