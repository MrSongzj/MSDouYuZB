//
//  FunnyPresenter.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/9.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import Foundation

class FunnyPresenter:
    BaseTVCateVCDataSource
{
    lazy var tvCateArr = [TVCate]()
    
    func requestFunnyData(responseCallback: (() -> ())?  = nil ) {
        NetworkTools.get(urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit": 30, "offset": 0]) { (result) in
            // 将 result 转成字典
            guard let responseData = result as? [String: Any] else { return }
            // 获取字典里的 data 数据
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            // 遍历数组里的字典，转成 model 对象
            let cate = TVCate()
            for dict in dataArray {
                cate.roomArr.append(TVRoom(dict: dict))
            }
            self.tvCateArr.append(cate)
            // 回调
            if let callback = responseCallback {
                callback()
            }
        }
    }
}
