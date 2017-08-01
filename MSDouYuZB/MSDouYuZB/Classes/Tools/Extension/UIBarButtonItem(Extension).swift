//
//  UIBarButtonItem(Extension).swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/28.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /// 导航栏图片按钮构造方法
    convenience init(normalImgName: String, highlightImgName: String = "", width: CGFloat = 0) {
        // 按钮的宽度可以自定义
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        btn.setImage(UIImage(named: normalImgName), for: .normal)
        if !highlightImgName.isEmpty {
            btn.setImage(UIImage(named: highlightImgName), for: .highlighted)
        }
        if width <= 0 {
            // 没有设置宽度时根据图片自适应尺寸
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
