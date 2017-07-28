//
//  MainViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/7/28.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(name: "Home")
        addChildVC(name: "Live")
        addChildVC(name: "Follow")
        addChildVC(name: "Profile")
    }
    
    private func addChildVC(name: String) {
        // 通过 storyboard 获取视图控制器
        let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(vc)
    }
}
