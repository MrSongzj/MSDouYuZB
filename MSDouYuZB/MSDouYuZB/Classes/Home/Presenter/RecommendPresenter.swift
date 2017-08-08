//
//  RecommendPresenter.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import Foundation

class RecommendPresenter {
    
    // MARK: - 属性
    
    lazy var tvCateArr = [TVCate]()
    lazy var scrollCycleItemArr = [ScrollCycleItem]()
    
    // MARK: - Public Methods
    
    func requestScrollCycleData(responseCallback: (() -> ())? = nil) {
        NetworkTools.get(urlString: "http://capi.douyutv.com/api/v1/slide/6", parameters: ["version": "2.300"]) { (result) in
            // 将 result 转成字典
            guard let responseData = result as? [String: Any] else { return }
            // 获取字典里的 data 数据
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            // 遍历数组里的字典，转成 model 对象
            for dict in dataArray {
                self.scrollCycleItemArr.append(ScrollCycleItem(dict: dict))
            }
            // 回调
            if let callback = responseCallback {
                callback()
            }
        }
    }
    
    func requestTVData(responseCallback: (() -> ())? = nil) {
        let parameters: [String: Any] = ["limit": 4, "offset": 0, "time": NSDate.currentTimeInterval]
        // 因为请求回来的数据顺序是不定的，所以使用 DispatchGroup 来确定所有数据回来的时间
        let group = DispatchGroup.init()
        
        // 1. 获取热门分类的数据
        let hotCate = TVCate()
        hotCate.tag_name = "热门"
        hotCate.icon_name = "home_header_hot"
        // 进入组
        group.enter()
        NetworkTools.get(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.currentTimeInterval]) { (result) in
            // 将 result 转成字典
            guard let responseData = result as? [String: Any] else { return }
            // 获取字典里的 data 数据
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            // 遍历数组里的字典，转成 model 对象
            for dict in dataArray {
                hotCate.roomArr.append(TVRoom(dict: dict))
            }
            // 离开组
            group.leave()
        }
        // 2. 获取颜值分类的数据
        let prettyCate = TVCate()
        prettyCate.tag_name = "颜值"
        prettyCate.icon_name = "home_header_phone"
        group.enter()
        NetworkTools.get(urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let responseData = result as? [String: Any] else { return }
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            
            for dict in dataArray {
                let tvRoom = TVRoom(dict: dict)
                prettyCate.roomArr.append(tvRoom)
            }
            
            group.leave()
        }
        // 3. 获取剩余部分分类的数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1501751797.7955
        group.enter()
        NetworkTools.get(urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit": 4, "offset": 0, "time": NSDate.currentTimeInterval]) { (result) in
            guard let responseData = result as? [String: Any] else { return }
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            
            for dict in dataArray {
                let cate = TVCate(dict: dict)
                self.tvCateArr.append(cate)
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: { 
            self.tvCateArr.insert(prettyCate, at: 0)
            self.tvCateArr.insert(hotCate, at: 0)
            
            if let callback = responseCallback {
                callback()
            }
        }))
    }
}
