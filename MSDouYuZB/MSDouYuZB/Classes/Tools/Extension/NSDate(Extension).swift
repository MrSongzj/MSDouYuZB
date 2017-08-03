//
//  NSDate(Extension).swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import Foundation

extension NSDate {
    
    static var currentTimeInterval: TimeInterval {
        return NSDate().timeIntervalSince1970
    }
}
