//
//  CustomNavigationController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/11.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGes = interactivePopGestureRecognizer else { return }
        // 取出 View
        guard let gesView = systemGes.view else { return }
        /*
        // 打印一个类里的成员变量
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0 ..< Int(count) {
            let ivar = ivars[i]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        // 取出 target
        guard let target = targetObjc.value(forKey: "target") else { return }
        // 取出 action
        let action = Selector(("handleNavigationTransition:"))
        // 创建自定义手势
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        gesView.addGestureRecognizer(panGes)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
