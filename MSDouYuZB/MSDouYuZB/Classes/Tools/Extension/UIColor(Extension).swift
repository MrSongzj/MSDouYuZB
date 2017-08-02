//
//  UIColor(Extension).swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/31.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

typealias RGBA = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    
    /// 针对两个 UIColor 对象转换
    ///
    /// - Parameters:
    ///   - fromColor: 源颜色
    ///   - toColor: 目标颜色
    ///   - progress: 进度
    /// - Returns: 当前进度颜色
    static func transferColor(_ fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> UIColor {
        let fRGBA = fromColor.getRGBA()
        let tRGBA = toColor.getRGBA()
        return transferRGBA(fRGBA, toRGBA: tRGBA, progress: progress)
    }
    
    /// 针对两个 RGBA 值转换
    ///
    /// - Parameters:
    ///   - fromRGBA: 源 RGBA 值
    ///   - toRGBA: 目标 RGBA 值
    ///   - progress: 进度
    /// - Returns: 当前进度颜色
    static func transferRGBA(_ fromRGBA: RGBA, toRGBA: RGBA, progress: CGFloat) -> UIColor {
        var p = progress
        if p > 1 {
            p = 1
        } else if (p < 0) {
            p = 0
        }
        let r = fromRGBA.r + (toRGBA.r - fromRGBA.r) * p
        let g = fromRGBA.g + (toRGBA.g - fromRGBA.g) * p
        let b = fromRGBA.b + (toRGBA.b - fromRGBA.b) * p
        let a = fromRGBA.a + (toRGBA.a - fromRGBA.a) * p
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /// 获取 UIColor 对象的 RGBA 值
    ///
    /// - Returns: RGBA 值
    func getRGBA() -> RGBA {
        var r, g, b, a: CGFloat
        r = 0; g = 0; b = 0; a = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}
