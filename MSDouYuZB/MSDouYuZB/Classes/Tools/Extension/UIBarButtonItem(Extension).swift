//
//  UIBarButtonItem(Extension).swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/28.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(normalImgName: String, highlightImgName: String = "") {
        let btn = UIButton()
        btn.setImage(UIImage(named: normalImgName), for: .normal)
        if !highlightImgName.isEmpty {
            btn.setImage(UIImage(named: highlightImgName), for: .highlighted)
        }
        btn.sizeToFit()
        self.init(customView: btn)
    }
    
    convenience init(width: CGFloat) {
        self.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        self.width = width
    }
}
