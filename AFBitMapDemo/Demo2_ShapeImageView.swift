//
//  Demo2_ShapeImageView.swift
//  AFBitMapDemo
//
//  Created by Afry on 16/3/5.
//  Copyright © 2016年 Afry. All rights reserved.
//

import UIKit

class Demo2_ShapeImageView: UIImageView {

    var basicImage:UIImage?
    
    func changeShape(points:[CGPoint]){
        
        var p0 = points[0]
        var p1 = points[1]
        var p2 = points[2]
        var p3 = points[3]
        
        // 当前view距父View左上角的相对距离，和理论大小
        let minLeft = min(min(p0.x, p1.x), min(p2.x, p3.x));
        let minTop = min(min(p0.y, p1.y), min(p2.y, p3.y));
        let shapeWidth = max(max(p0.x, p1.x), max(p2.x, p3.x))-min(min(p0.x, p1.x), min(p2.x, p3.x));
        let shapeHeight = max(max(p0.y, p1.y), max(p2.y, p3.y))-min(min(p0.y, p1.y), min(p2.y, p3.y));
        
        // 修正点的位置为相对自身
        p0.x = p0.x - minLeft;
        p1.x = p1.x - minLeft;
        p2.x = p2.x - minLeft;
        p3.x = p3.x - minLeft;
        p0.y = p0.y - minTop;
        p1.y = p1.y - minTop;
        p2.y = p2.y - minTop;
        p3.y = p3.y - minTop;
        
        // 获取图片信息
        let imgCGImage = basicImage!.CGImage
        let imgWidth = CGImageGetWidth(imgCGImage)
        let imgHeight = CGImageGetHeight(imgCGImage)
        
        // 位图的大小 ＝ 图片宽 ＊ 图片高 ＊ 图片中每点包含的信息量
        let imgByteCount = imgWidth * imgHeight * 4
        
        // 使用系统的颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 根据位图大小，申请内存空间
        let imgData = malloc(imgByteCount)
        defer {free(imgData)}
        
        // 创建一个位图
        let imgContext = CGBitmapContextCreate(imgData,
                                                imgWidth,
                                                imgHeight,
                                                8,
                                                imgWidth * 4,
                                                colorSpace,
                                                CGImageAlphaInfo.PremultipliedFirst.rawValue)
         
         // 图片的rect
        let imgRect = CGRectMake(0, 0, CGFloat(imgWidth), CGFloat(imgHeight))
        
        // 将图片画到位图中
        CGContextDrawImage(imgContext, imgRect, imgCGImage)
        
        // 获取位图数据
        /**
         强转指针类型
         参考:http://www.csdn.net/article/2015-01-20/2823635-swift-pointer
         http://c.biancheng.net/cpp/html/2282.html
         */
        let newImgData = unsafeBitCast(CGBitmapContextGetData(imgContext), UnsafeMutablePointer<CUnsignedChar>.self)
        
        // 计算总大小,申请内存空间
        let shapeByteCount = Int((shapeWidth * shapeHeight) * 4)
        let shapeVoideData = malloc(shapeByteCount)
        defer {free(shapeVoideData)}
        let shapeData = unsafeBitCast(shapeVoideData, UnsafeMutablePointer<CUnsignedChar>.self)
        
        // 初始化数据
        for (var i=0; i<Int(shapeHeight); i++) {
            for (var j=0; j<Int(shapeWidth); j++) {
                let offset = (i*Int(shapeWidth) + j)*4
                (shapeData+offset).memory = 0
                (shapeData+offset+1).memory = 0
                (shapeData+offset+2).memory = 0
                (shapeData+offset+3).memory = 0
            }
        }
        
        // 数据处理
        for (var i=0; i<Int(imgHeight)-1; i++) {
            for (var j=0; j<Int(imgWidth)-1; j++) {
                // 在原图中的位置
                let offset = (i*Int(imgWidth) + j)*4
                
                // 计算原图每个点在新图中的位置
                let xFactor = CGFloat(j)/CGFloat(imgWidth)
                let yFactor = CGFloat(i)/CGFloat(imgHeight)
                
                var delX = (p1.x-p0.x)*xFactor
                var delY = (p1.y-p0.y)*xFactor
                let top = CGPointMake(p0.x+delX, p0.y+delY)
                
                delX = (p2.x-p3.x)*xFactor
                delY = (p2.y-p3.y)*xFactor
                let bottom = CGPointMake(p3.x+delX, p3.y+delY)
                
                delX = (bottom.x-top.x)*yFactor
                delY = (bottom.y-top.y)*yFactor
                let newPoint = CGPointMake(top.x+delX, top.y+delY)
                
                let newIndex = (Int(newPoint.y)*Int(shapeWidth)+Int(newPoint.x))*4
                
                // 修改值
                (shapeData+newIndex).memory = (newImgData+offset).memory
                (shapeData+newIndex+1).memory = (newImgData+offset+1).memory
                (shapeData+newIndex+2).memory = (newImgData+offset+2).memory
                (shapeData+newIndex+3).memory = (newImgData+offset+3).memory
                
            }
        }
        
        // 创建新图的上下文
        let shapeContext = CGBitmapContextCreateWithData(shapeData,
                                                    Int(shapeWidth),
                                                    Int(shapeHeight),
                                                    8,      // bits per component
                                                    Int(shapeWidth)*4,
                                                    colorSpace,
                                                    CGImageAlphaInfo.PremultipliedFirst.rawValue,
                                                    nil,nil);
        
        let outImage = CGBitmapContextCreateImage(shapeContext)
        
        // 根据图形上下文绘图
        let img = UIImage(CGImage: outImage!)
        
        // 配置新图片
        self.frame = CGRectMake(minLeft, minTop, shapeWidth, shapeHeight)
        self.image = img
    }
}
