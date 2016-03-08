//
//  Demo1_ViewController.swift
//  AFBitMapDemo
//
//  Created by Afry on 16/3/3.
//  Copyright © 2016年 Afry. All rights reserved.
//

import UIKit


class Demo1_ViewController: UIViewController {
    
    var resultView:UIButton?
    var imgView:UIImageView?
    var pointView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ColorPicker"
        
        // 图片view
        let img = UIImage(named: "cat")
        let imgFrame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height-114)
        imgView = UIImageView(frame: imgFrame)
        imgView!.image = img
        view.addSubview(imgView!)
        
        // 结果view
        let resultFrame = CGRectMake(0, view.frame.size.height-50, view.frame.size.width, 50)
        resultView = UIButton(frame: resultFrame)
        resultView!.backgroundColor = UIColor.whiteColor()
        view.addSubview(resultView!)
        // 结果view的颜色
        resultView!.setTitle("Current Color ", forState: .Normal)
        resultView!.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0)
        resultView!.setTitleColor(UIColor.blackColor(), forState: .Normal)
        resultView!.titleLabel!.font = UIFont(name: "Zapfino", size: 18)
        // 结果view的边框
        resultView!.layer.bounds = resultView!.bounds
        resultView!.layer.borderWidth = 3
        resultView!.layer.borderColor = UIColor.cyanColor().CGColor
        
        // 当前选中位置的view
        pointView = UIView(frame: CGRectMake(0, 0, 20, 20))
        let showLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRectMake(0, 0, 20, 20), cornerRadius: 10)
        showLayer.path = path.CGPath
        showLayer.fillColor = UIColor.clearColor().CGColor
        showLayer.strokeColor = UIColor.blueColor().CGColor
        showLayer.lineWidth = 2
        pointView!.layer.addSublayer(showLayer)
        imgView!.addSubview(pointView!)
        
        // 根据起始位置设置颜色
        changeCurrentColor(pointView!.center)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 根据手指位置设置颜色
        let touch = touches.first
        let p = touch!.locationInView(imgView!)
        pointView!.center = p
        changeCurrentColor(p)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 根据手指位置设置颜色
        let touch = touches.first
        let p = touch!.locationInView(imgView!)
        pointView!.center = p
        changeCurrentColor(p)
    }
    
    func  changeCurrentColor(point:CGPoint){
        
        // 获取图片大小
        let imgWidth = CGFloat(CGImageGetWidth(imgView!.image!.CGImage))
        let imgHeight = CGFloat(CGImageGetHeight(imgView!.image!.CGImage))
        
        // 当前点在图片中的相对位置
        let pInImage = CGPointMake(point.x * imgWidth / imgView!.bounds.size.width,
            point.y * imgHeight / imgView!.bounds.size.height)
        
        // 获取并设置颜色
        resultView!.backgroundColor = Demo1_ColorPicker.getColor(pInImage, image: imgView!.image!)
    }
    

}
