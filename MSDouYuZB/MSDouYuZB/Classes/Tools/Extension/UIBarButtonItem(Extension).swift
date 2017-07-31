//
//  UIBarButtonItem(Extension).swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/28.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(normalImgName: String, highlightImgName: String = "", width: CGFloat = 0) {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        btn.setImage(UIImage(named: normalImgName), for: .normal)
        if !highlightImgName.isEmpty {
            btn.setImage(UIImage(named: highlightImgName), for: .highlighted)
        }
        if width <= 0 {
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
