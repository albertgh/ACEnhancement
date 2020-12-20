//
//  CGFloat+ACEnhance.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/27.
//

import UIKit

extension CGFloat: ACENamespace {}

extension ACENamespaceWrapper where WrappedType == CGFloat {
    public static var zero: CGFloat {
        return 0.0
    }
    public var half: CGFloat {
        let `self` = wrappedValue
        return self / 2.0
    }    
}
