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
    private lazy var tvCateArr = [TVCate]()
    
    
    func requestData() {
        // 1.
        // 2.
        // 3.获取剩余部分分类的数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1501751797.7955
        NetworkTools.get(urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit": 4, "offset": 0, "time": NSDate.currentTimeInterval]) { (result) in
            guard let responseData = result as? [String: Any] else { return }
            guard let dataArray = responseData["data"] as? [[String: NSObject]] else { return }
            
            for dict in dataArray {
                let cate = TVCate(dict: dict)
                self.tvCateArr.append(cate)
            }
            
            for cate in self.tvCateArr {
                for room in cate.roomArr {
                    print(room.nickname)
                }
                print("---------")
            }
        }
    }
}
