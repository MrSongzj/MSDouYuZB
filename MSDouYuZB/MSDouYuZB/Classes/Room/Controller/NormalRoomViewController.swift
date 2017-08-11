//
//  NormalRoomViewController.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/11.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class NormalRoomViewController: UIViewController,
    UIGestureRecognizerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
