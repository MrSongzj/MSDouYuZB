//
//  AmusePresenter.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/8.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import Foundation

class AmusePresenter:
    BaseTVCateVCDataSource
{
    
    // MARK: - 属性
    
    lazy var tvCateArr = [TVCate]()
    
    // MARK: - Public Methods
    
    func requestAmuseData(responseCallback: (() -> ())? = nil) {
        NetworkTools.get(urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            // 将 result 转成字典
            guard let responseData = result as? [String: Any] else { return }
            // 获取字典里的 data 数据
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            // 遍历数组里的字典，转成 model 对象
            for dict in dataArray {
                self.tvCateArr.append(TVCate.init(dict: dict))
            }
            // 回调
            if let callback = responseCallback {
                callback()
            }
        }
    }
    
}
