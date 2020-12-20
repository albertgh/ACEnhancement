//
//  UIScrollView+ACEnhance.swift
//  InstaSlide
//
//  Created by albertchu on 2020/11/27.
//

import UIKit

extension ACENamespaceWrapper where WrappedType: UIScrollView {
    public func setContentOffsetY(_ offsetY: CGFloat) {
        let `self` = wrappedValue
        
        var contentOffset: CGPoint = self.contentOffset
        contentOffset.y = offsetY
        self.contentOffset = contentOffset
    }
    
    public func setContentOffsetX(_ offsetX: CGFloat) {
        let `self` = wrappedValue
        
        var contentOffset: CGPoint = self.contentOffset
        contentOffset.x = offsetX
        self.contentOffset = contentOffset
    }
}
