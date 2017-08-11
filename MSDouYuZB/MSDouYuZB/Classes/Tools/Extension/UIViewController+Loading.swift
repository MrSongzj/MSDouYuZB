//
//  UIViewController+Loading.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/10.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    let imageV: UIImageView = UIImageView(image: UIImage(named: "img_loading_1"))
    
    convenience init(inView: UIView) {
        self.init(frame: inView.bounds)
        
        imageV.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageV.animationDuration = 0.5
        imageV.animationRepeatCount = Int.max
        
        imageV.center = self.center
        imageV.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin]
        self.addSubview(imageV)
        
        self.backgroundColor = UIColor.white
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        inView.addSubview(self)
    }
}

extension UIViewController {
    
    @discardableResult func showLoading() -> Bool {
        
        for subV in view.subviews {
            if subV is LoadingView {
                return false
            }
        }
        
        let loadingV = LoadingView(inView: view)
        loadingV.imageV.startAnimating()
        
        return true
    }
    
    @discardableResult func hideLoading() -> Bool {
        
        for subV in view.subviews {
            if subV is LoadingView {
                let loadingV = subV as! LoadingView
                loadingV.imageV.stopAnimating()
                loadingV.removeFromSuperview()
                return true
            }
        }
        
        return false
    }
    
}
