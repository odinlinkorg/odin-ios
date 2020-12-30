//
//  UILabel+HSExtension.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/4.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func numberAnimation(toTheValue maxValue:String){
        self.numberAnimation(toTheValue: maxValue, prefix: "", unit: "")
    }

    /// 数字增长动画
    /// - Parameters:
    ///   - maxValue: 最终值
    ///   - unit: 后缀单位
    public func numberAnimation(toTheValue maxValue:String, unit:String){
        self.numberAnimation(toTheValue: maxValue, prefix: "", unit: unit)
    }

    /// 数字增长动画
    /// - Parameters:
    ///   - maxValue: 最终值
    ///   - prefix: 前缀
    ///   - unit: 后缀单位
    public func numberAnimation(toTheValue maxValue:String, prefix:String, unit:String){
        let maxNumber = maxValue.doubleValue
        var curNumber = 0.00
        let stepValue = maxNumber/60.0
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是10毫秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(10))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            DispatchQueue.main.async {
    //                print(curNumber)
                self.text = String.init(format: "%@%.2f %@", prefix,curNumber,unit)
                curNumber += stepValue
                if curNumber >= maxNumber {
                    self.text = String.init(format: "%@%@ %@", prefix,maxValue,unit)
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }

}
