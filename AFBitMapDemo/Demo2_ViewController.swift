//
//  Demo2_ViewController.swift
//  AFBitMapDemo
//
//  Created by Afry on 16/3/3.
//  Copyright © 2016年 Afry. All rights reserved.
//

import UIKit

class Demo2_ViewController: UIViewController {

    var shapeImageView:Demo2_ShapeImageView?
    var views:[UIView]?
    var selectedView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ShapeImageView"
        view.backgroundColor = UIColor.whiteColor()
        
        // 设置图片view
        let img = UIImage(named: "cat")
        shapeImageView = Demo2_ShapeImageView()
        shapeImageView!.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height-64)
        shapeImageView!.basicImage = img
        view.addSubview(shapeImageView!)
        
        // 设置可拖动的按钮
        let v0 = UIView(frame: CGRectMake(50, 150, 20, 20))
        let v1 = UIView(frame: CGRectMake(200, 150, 20, 20))
        let v2 = UIView(frame: CGRectMake(200, 400, 20, 20))
        let v3 = UIView(frame: CGRectMake(50, 400, 20, 20))
        views = [v0,v1,v2,v3]
        
        for v in views! {
            v.backgroundColor = UIColor.blueColor()
            view!.addSubview(v)
        }
        
        let arr = [views![0].center,views![1].center,views![2].center,views![3].center]
        shapeImageView!.changeShape(arr)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let p = t!.locationInView(view)
        
        // 检测选中的“可拖动按钮”
        for v in views! {
            if CGRectContainsPoint(v.frame, p) {
                selectedView = v
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let p = t!.locationInView(view)
        
        // 更新图片
        selectedView?.center = p
        let arr = [views![0].center,views![1].center,views![2].center,views![3].center]
        shapeImageView!.changeShape(arr)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        selectedView = nil
    }
    
}
