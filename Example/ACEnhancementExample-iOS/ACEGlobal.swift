//
//  ACEGlobal.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/12/6.
//

import Foundation

public func ace_delay(by delayTime: TimeInterval,
                      qosClass: DispatchQoS.QoSClass? = nil,
                      _ closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : .main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}
